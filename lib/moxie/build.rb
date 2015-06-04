module Moxie
  class Build < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    extend Finders
    keyspace 'build'
    property :id,      required: true
    property :app,     required: true
    property :branch,  required: true
    property :version, required: true
    property :status,  default: 'pending'

    def self.create(options)
      application = Application.find(options.fetch(:app))

      id =  Generate.id
      version = Generate.version

      options.merge!({ id: id, version: version })

      build = new(options)
      Store.object("build:#{build.id}").save(build.to_hash)
      Store.set("builds").add(build.id)
      Store.set("application:#{application.id}:builds").add(build.id)
      build
    end

    def application
      Application.find(app)
    end

    def repo
      application.repo
    end
  end
end

