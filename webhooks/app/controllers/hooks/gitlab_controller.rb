class Hooks::GitlabController < ApplicationController
  def create
    body = {
      source_url: params.dig('repository', 'git_http_url'),
      commit_id: params.dig('after')
    }
    LicenseFinderJob.perform_later body
  end
end
