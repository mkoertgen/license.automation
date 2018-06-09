require 'test_helper'

class Hooks::GitlabControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'gitlab push hook' do
    # cf.: https://docs.gitlab.com/ee/user/project/integrations/webhooks.html#push-events
    gitlab_body = {
      object_kind: 'push',
      after: 'da1560886d4f094c3e6c9ef40349f7d38b5d27d7',
      repository: {
        git_http_url: 'http://example.com/mike/diaspora.git'
      }
    }.deep_stringify_keys

    body = {
      source_url: gitlab_body.dig('repository', 'git_http_url'),
      commit_id: gitlab_body.dig('after')
    }
    perform_enqueued_jobs do
      stub_request(:post, 'http://license_finder:5000/').
        with(body: body.to_json)
      post_json hooks_gitlab_index_path, gitlab_body
      assert_response 204
    end
  end
end
