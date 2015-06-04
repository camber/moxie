require "json"
require "securerandom"

require "hashie"
require "redis"
require "redis-namespace"
require "thor"

require_relative "moxie/version"
require_relative "moxie/errors"
require_relative "moxie/transforms"
require_relative "moxie/id"
require_relative "moxie/store"
require_relative "moxie/finders"
require_relative "moxie/application"
require_relative "moxie/environment"
require_relative "moxie/cli"

module Moxie
  REDIS_NAMESPACE = 'moxie'

  def self.redis
    Redis::Namespace.new(REDIS_NAMESPACE, redis: Redis.current)
  end
end

