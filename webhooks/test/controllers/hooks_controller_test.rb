require 'test_helper'

class HooksControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'github push hook' do
    # cf.: https://developer.github.com/v3/activity/events/types/#pushevent
    hook_json = {
        after: '0d1a26e67d8f5eaf1f6ba5c57fc3c7d91ac0fd1c',
        repository: {
            clone_url: 'https://github.com/baxterthehacker/public-repo.git',
        }
    }.deep_stringify_keys

    job_body = {
        source_url: hook_json.dig('repository', 'clone_url'),
        commit_id: hook_json.dig('after')
    }

    assert_job_hook hooks_github_path, hook_json, job_body
  end

  test 'gitlab push hook' do
    # cf.: https://docs.gitlab.com/ee/user/project/integrations/webhooks.html#push-events
    hook_json = {
        object_kind: 'push',
        after: 'da1560886d4f094c3e6c9ef40349f7d38b5d27d7',
        repository: {
            git_http_url: 'http://example.com/mike/diaspora.git'
        }
    }.deep_stringify_keys

    job_body = {
        source_url: hook_json.dig('repository', 'git_http_url'),
        commit_id: hook_json.dig('after')
    }

    assert_job_hook hooks_gitlab_path, hook_json, job_body
  end

  private

  def assert_job_hook(path, hook_json, job_body)
    perform_enqueued_jobs do
      stub_request(:post, 'http://license_finder:5000/')
          .with(body: job_body.to_json)
      post_json path, hook_json
      assert_response 204
    end
  end
end