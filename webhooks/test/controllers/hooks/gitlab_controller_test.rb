require 'test_helper'

class Hooks::GitlabControllerTest < ActionDispatch::IntegrationTest
  test 'gitlab push hook' do
    # cf.: https://docs.gitlab.com/ee/user/project/integrations/webhooks.html#push-events
    gitlab_body = {
      object_kind: 'push',
      checkout_sha: '1bbc5189ff1a1a57a3ada6811b365f5b5b898250',
      repository: {
        url: 'git@github.com:awesome-inc/neo4j-decorator.git',
        git_http_url: 'https://github.com/awesome-inc/neo4j-decorator.git',
        git_ssh_url: 'git@github.com:awesome-inc/neo4j-decorator.git',
      }
    }.deep_stringify_keys

    body = {
      source_url: gitlab_body.dig('repository', 'git_http_url'),
      commit_id: gitlab_body.dig('checkout_sha')
    }
    stub_request(:post, 'http://license_finder:5000/').
      with(body: body.to_json).
      to_return(status: 200)

    post_json hooks_gitlab_index_path, gitlab_body
    assert_response 204
  end
end
