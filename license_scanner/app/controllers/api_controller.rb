# Api controller
class ApiController < ApplicationController
  def scan
    url = params.require(:url)
    commit = params.require(:commit)
    csv = Scanner.call(url, commit)
    render plain: csv
  end

  def github
    LicenseFinderJob.perform_later body('clone_url')
  end

  def gitlab
    LicenseFinderJob.perform_later body('git_http_url')
  end

  private

  def body(url_key)
    url = params.require(:repository).require(url_key)
    commit = params.require(:after)
    { url: url, commit: commit }
  end
end
