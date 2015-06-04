module Moxie
  class Application < Hashie::Trash
    extend Finders
    include Hashie::Extensions::IndifferentAccess

    key 'application'

    property :name, required: true, transform_with: Transforms::Slug
    property :repo, required: true

    def id
      name
    end

    def environment_ids
      Store.set("application:#{id}:environments").to_a
    end

    def environments
      Environment.find(environment_ids)
    end

    def self.create(options)
      application = new(options)
      raise Exists, "Application '#{application.name}' already exists" if exists?(application.name)
      Store.object("application:#{application.name}").save(application.to_hash)
      Store.set("applications").add(application.name)
      application
    end

    def self.delete(name)
      application = find(name)
      Store.object("application:#{application.name}").delete
      Store.set("applications").remove(application.name)
    end

    def self.exists?(id)
      ids.include?(id)
    end

  end
end

