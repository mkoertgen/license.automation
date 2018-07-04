require 'csv'

# license finder job
class LicenseFinderJob < ApplicationJob
  queue_as :default

  LICENSE_FINDER_URL = ENV.fetch('LICENSE_FINDER_URL') { 'http://localhost:5000' }.freeze
  COLUMNS = %w[package_manager name version homepage licenses license_links]
  ELASTIC_SEARCH_URL = ENV.fetch('ELASTIC_SEARCH_URL') { 'http://localhost:9200' }.freeze

  def perform(body)
    request = body.merge(format: 'csv', columns: COLUMNS)
    response = checked { HTTP.post(LICENSE_FINDER_URL, json: request) }
    body = bulk_for meta(request), response.to_s
    checked do
      HTTP.headers(content_type: 'application/x-ndjson')
        .post("#{ELASTIC_SEARCH_URL}/_bulk", body: body)
    end
  end

  private

  def checked
    response = yield
    raise HTTP::ResponseError, "#{response.uri}: #{response}" unless response.status.success?
    response
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
    url = URI(request[:source_url])
    _p, owner, name = url.path.split('/', 3)
    name.chomp!('.git')
    {
      timestamp: Time.now.utc.iso8601,
      repository: { url: url.to_s, owner: owner, name: name }
    }
  end
end
