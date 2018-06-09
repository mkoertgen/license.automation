class Hooks::GithubController < ApplicationController
  def create
    LicenseFinderJob.perform_later
  end
end
