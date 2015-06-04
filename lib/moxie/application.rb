module Moxie
  class Application < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    extend Finders

    keyspace 'application'
    property :name, required: true, transform_with: Transforms::Slug
    property :repo, required: true

    def id
      name
    end

    def build_ids
      Store.set("application:#{id}:builds").to_a
    end

    def builds
      Build.find(build_ids)
    end

    def self.create(options)
      application = new(options)
      raise Exists, "Application '#{application.id}' already exists" if exists?(application.id)
      Store.object("application:#{application.id}").save(application.to_hash)
      Store.set("applications").add(application.id)
      application
    end

    def self.update(id, options)
      application = find(id)
      hash = application.to_hash.merge(options)
      Store.object("application:#{application.id}").save(hash)
    end

    def self.delete(id)
      application = find(id)
      Store.object("application:#{application.id}").delete
      Store.set("applications").remove(application.id)
    end

    def self.exists?(id)
      ids.include?(id)
    end

  end
end

