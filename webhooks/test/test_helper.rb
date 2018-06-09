ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...

  # cf.: https://gist.github.com/dteoh/2d4c115446e2429824b6945c45c07f3b
  def post_json(path, obj)
    post path, params: obj.to_json, headers: { 'Content-Type' => 'application/json' }
  end
end
