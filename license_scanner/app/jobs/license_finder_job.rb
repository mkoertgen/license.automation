require 'csv'

# license finder job
class LicenseFinderJob < ApplicationJob
  queue_as :default

  ELASTIC_SEARCH_URL = ENV.fetch('ELASTIC_SEARCH_URL') { 'http://localhost:9200' }.freeze

  def perform(request)
    url = request[:url]
    commit = request[:commit]
    csv = Scanner.call(url, commit)
    body = bulk_for meta(request), csv
    checked do
      HTTP.headers(content_type: 'application/x-ndjson')
          .post("#{ELASTIC_SEARCH_URL}/_bulk", body: body)
    end
  end

  private

  def checked
    r = yield
    raise HTTP::ResponseError, "#{r.uri}: #{r}" unless r.status.success?
    r
  end

  def bulk_for(meta, csv)
    # cf.: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html
    index = "packages-#{Time.now.utc.strftime('%Y_%m_%d')}"
    bulk = []
    CSV.parse(csv) do |row|
      id = SecureRandom.uuid
      type, name, version, homepage, license, license_url = row
      header = { index: { _index: index, _type: type, _id: id } }
      bulk << header.to_json
      doc = {
        name: name,
        version: version,
        homepage: homepage,
        license: { name: license, url: license_url }
      }
      doc = meta.merge doc
      bulk << doc.to_json
    end
    bulk.join("\n") + "\n"
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
end
