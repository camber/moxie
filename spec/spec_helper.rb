$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'moxie'
require 'mock_redis'
require 'factory_girl'
require_relative './factories.rb'

$mock_redis = MockRedis.new

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    allow(Moxie).to receive(:redis).and_return($mock_redis)
  end
end

