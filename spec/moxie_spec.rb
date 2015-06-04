require 'spec_helper'

describe Moxie do
  it "has a version number" do
    expect(Moxie::VERSION).not_to be nil
  end
end

describe Moxie, ".redis" do
  before do
    # Redefine the stubbed :redis method on Moxie so we can test it.
    # It is stubbed to return a MockRedis instance in spec/spec_helper.rb
    expect(Moxie).to receive(:redis).and_call_original
  end

  it "returns a namespaced Redis instance" do
    redis = double
    namespaced_redis = double
    allow(Redis).to receive(:current).and_return(redis)
    allow(Redis::Namespace).to receive(:new).with('moxie', redis: redis).and_return(namespaced_redis)
    expect(Moxie.redis).to eql namespaced_redis
  end
end

