require 'test_helper'

class Hooks::GithubControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'gitlab push hook' do
    # cf.: https://developer.github.com/v3/activity/events/types/#pushevent
    github_body = {
      after: '0d1a26e67d8f5eaf1f6ba5c57fc3c7d91ac0fd1c',
      repository: {
        clone_url: 'https://github.com/baxterthehacker/public-repo.git',
      }
    }.deep_stringify_keys

    body = {
      source_url: github_body.dig('repository', 'clone_url'),
      commit_id: github_body.dig('after')
    }
    perform_enqueued_jobs do
      stub_request(:post, 'http://license_finder:5000/').
        with(body: body.to_json)
      post_json hooks_github_index_path, github_body
      assert_response 204
    end
  end
end
