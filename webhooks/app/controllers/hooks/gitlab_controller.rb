class Hooks::GitlabController < ApplicationController
  def create
    LicenseFinderJob.perform_later
  end
end
