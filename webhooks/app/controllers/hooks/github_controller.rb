class Hooks::GithubController < ApplicationController
  def create
    body = {
      source_url: params.dig('repository', 'clone_url'),
      commit_id: params.dig('after')
    }
    LicenseFinderJob.perform_later body
  end
end
