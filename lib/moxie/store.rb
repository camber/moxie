module Moxie
  class Store
    def self.set(key)
      Store::Set.new(key)
    end

    def self.object(key)
      Store::Object.new(key)
    end

    attr_reader :key

    def initialize(key)
      @key = key
    end

    class Set < Store
      def to_a
        Moxie.redis.smembers(key)
      end

      def add(value)
        Moxie.redis.sadd(key, value)
      end

      def remove(value)
        Moxie.redis.srem(key, value)
      end
    end

    class Object < Store
      def to_hash
        json = Moxie.redis.get(key)
        begin
          JSON.parse(json)
        rescue
          return {}
        end
      end

      def save(hash={})
        Moxie.redis.set(key, hash.to_json)
      end

      def delete
        Moxie.redis.del(key)
      end
    end

  end
end

