require_relative '../config/environment'
require 'rack/test'

RSpec.configure do |config|

  config.include Rack::Test::Methods
  config.color = true
  config.order = 'default'
end
