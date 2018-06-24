# license finder job
class LicenseFinderJob < ApplicationJob
  queue_as :default

  LICENSE_FINDER_URL = ENV.fetch('LICENSE_FINDER_URL') { 'http://localhost:5000' }.freeze
  COLUMNS = %w[package_manager name version homepage licenses license_links]
  ELASTICSEARCH_URL = ENV.fetch('ELASTIC_SEARCH_URL') { 'http://localhost:9200' }.freeze

  def perform(body)
    request = body.merge(format: 'csv', columns: COLUMNS)
    response = HTTP.post(LICENSE_FINDER_URL, json: request)

    # TODO...
    Rails.logger.info response
    # Convert to json -> post to elasticsearch
    # path = - /packages_YYYY-MM-DD/<package_manager> (e.g. Yarn)
    # {
    #    name: name,
    #    version: version [e.g. '0.1.0'],
    #    license: { name: name, url: license_links }
    #    homepage: homepage (e.g. Unknown),
    # }
    #
    #     slice = Date.today.strftime('%Y_%m_%d')
    #     path = "packages_#{slice}/#{type}type/
    #
    #     HTTP.post(   /_bulk, ...)
  end

  private

  def post

  end
end
