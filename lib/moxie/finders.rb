module Moxie
  module Finders
    def key(k=nil)
      @key = k unless k.nil?
      return @key
    end

    def ids
      Store.set("#{key}s").to_a
    end

    def all
      ids.map { |id| find(id) }
    end

    def find(*args)
      if args.first.is_a? Array
        find_multiple(*args)
      else
        find_one(args.first)
      end
    end

    def find_one(id)
      hash = Store.object("#{key}:#{id}").to_hash
      raise NotFound, "Could not find #{self.name.split(":").last.downcase} '#{id}'" if hash.empty?
      new(hash)
    end

    def find_multiple(ids)
      ids.map { |id| find_one(id) }
    end
  end
end

