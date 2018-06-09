class LicenseFinderJob < ApplicationJob
  queue_as :default

  LICENSE_FINDER_URL = ENV.fetch('LICENSE_FINDER_URL') { 'http://license_finder:5000' }.freeze

  def perform(body)
    response = HTTP.post(LICENSE_FINDER_URL, json: body)
    # TODO...
    Rails.logger.info response
  end
end
