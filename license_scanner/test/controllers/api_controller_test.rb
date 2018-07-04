require 'test_helper'

# Api controller tests
class ApiControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'github push hook' do
    # cf.: https://developer.github.com/v3/activity/events/types/#pushevent
    hook_json = {
      after: '0d1a26e67d8f5eaf1f6ba5c57fc3c7d91ac0fd1c',
      repository: {
        clone_url: 'https://github.com/baxterthehacker/public-repo.git',
      }
    }.deep_stringify_keys

    assert_job_hook api_github_path, hook_json
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

    assert_job_hook api_gitlab_path, hook_json
  end

  private

  def assert_job_hook(path, hook_json)
    csv = <<-EOF
Yarn,a-sync-waterfall,1.0.0,https://github.com/hydiak/a-sync-waterfall,MIT,http://opensource.org/licenses/mit-license
Yarn,abbrev,1.1.1,Unknown,ISC,http://en.wikipedia.org/wiki/ISC_license
EOF
    perform_enqueued_jobs do
      Scanner.stub :call, csv do
        stub_request(:post, "#{LicenseFinderJob::ELASTIC_SEARCH_URL}/_bulk")
        #.with_body # 'some licenses json'
        post_json path, hook_json
        assert_response 204
      end
    end
  end

  # cf.: https://gist.github.com/dteoh/2d4c115446e2429824b6945c45c07f3b
  def post_json(path, obj)
    post path, params: obj.to_json, headers: { 'Content-Type' => 'application/json' }
  end
end
