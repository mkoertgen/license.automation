require 'csv'

# license finder job
class LicenseFinderJob < ApplicationJob
  queue_as :default

  ELASTIC_SEARCH_URL = ENV.fetch('ELASTIC_SEARCH_URL') { 'http://localhost:9200' }.freeze

  def perform(request)
    csv = Scanner.call(request[:url], request[:commit])
    post_bulk csv_to_bulk(meta(request), csv)
  end

  private

  def csv_to_bulk(meta, csv)
    bulk = []
    index = "packages-#{Time.now.utc.strftime('%Y_%m_%d')}"
    CSV.parse(csv) { |row| bulk += row_to_bulk(index, meta, row) }
    bulk.join("\n") + "\n"
  end

  def row_to_bulk(index, meta, row)
    # cf.: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html
    type, name, version, homepage, license, license_url = row
    header = { index: { _index: index, _type: type, _id: SecureRandom.uuid } }
    doc = {
      name: name,
      version: version,
      homepage: homepage,
      license: { name: license, url: license_url }
    }
    [header.to_json, meta.merge(doc).to_json]
  end

  def meta(request)
    url = URI(request[:url])
    _p, owner, name = url.path.split('/', 3)
    name.chomp!('.git')
    {
      timestamp: Time.now.utc.iso8601,
      repository: { url: url.to_s, owner: owner, name: name }
    }
  end

  def post_bulk(body)
    r = HTTP.headers(content_type: 'application/x-ndjson')
            .post("#{ELASTIC_SEARCH_URL}/_bulk", body: body)
    raise HTTP::ResponseError, "#{r.uri}: #{r}" unless r.status.success?
  end
end
