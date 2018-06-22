# webhook controller
class HooksController < ApplicationController
  def github
    body = {
      source_url: params.dig('repository', 'clone_url'),
      commit_id: params.dig('after')
    }
    LicenseFinderJob.perform_later body
  end

  def gitlab
    body = {
      source_url: params.dig('repository', 'git_http_url'),
      commit_id: params.dig('after')
    }
    LicenseFinderJob.perform_later body
  end
end
