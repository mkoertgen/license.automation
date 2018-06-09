class LicenseFinderJob < ApplicationJob
  queue_as :default

  LICENSE_FINDER_URL = ENV.fetch('LICENSE_FINDER_URL') { 'http://license_finder:5000' }.freeze

  def perform(*args)
    # TODO: parse from args
    body = {
      source_url: 'https://github.com/awesome-inc/neo4j-decorator.git',
      commit_id: '012abe3'
    }

    response = HTTP.post(LICENSE_FINDER_URL, json: body)
    Rails.logger.info response
  end
end
