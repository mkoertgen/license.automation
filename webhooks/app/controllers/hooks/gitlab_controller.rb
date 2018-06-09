class Hooks::GitlabController < ApplicationController
  def create
    body = {
      source_url: params.dig('repository', 'git_http_url'),
      commit_id: params.dig('checkout_sha')
    }
    LicenseFinderJob.perform_later body
  end
end
