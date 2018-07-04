# Api controller
class ApiController < ApplicationController
  def github
    LicenseFinderJob.perform_later body('clone_url')
  end

  def gitlab
    LicenseFinderJob.perform_later body('git_http_url')
  end

  private

  def body(url_key)
    url = params.require(:repository).require(url_key) # URI.parse
    {
        source_url: url,
        commit_id: params.require(:after)
    }
  end
end
