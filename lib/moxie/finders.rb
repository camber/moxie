module Moxie
  module Finders
    def keyspace(k=nil)
      @keyspace = k unless k.nil?
      return @keyspace
    end

    def ids
      Store.set("#{keyspace}s").to_a
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
      hash = Store.object("#{keyspace}:#{id}").to_hash
      raise NotFound, "Could not find #{self.name.split(":").last.downcase} '#{id}'" if hash.empty?
      new(hash)
    end

    def find_multiple(ids)
      ids.map { |id| find_one(id) }
    end
  end
end

