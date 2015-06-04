module Moxie
  class Thor < ::Thor
    no_commands do
      def safely
        begin
          yield if block_given?
        rescue Moxie::Error => e
          puts e.message
          exit 1
        end
      end
    end
  end

  module Subcommands
    class App < Thor
      default_command :info

      desc "list", "List applications"
      def list
        puts Moxie::Application.all.sort_by(&:name)
      end

      desc "info <appname>", "Display an application"
      def info(name=nil)
        return list if name.nil?

        safely do
          application = Moxie::Application.find(name)
          puts application
        end
      end

      desc "create", "Create an application"
      option :name, required: true
      option :repo, required: true
      def create
        safely do
          Moxie::Application.create({
            name: options[:name],
            repo: options[:repo]
          })
        end
      end

      desc "delete <appname>", "Delete an application"
      def delete(name)
        safely do
          Moxie::Application.delete(name)
        end
      end
    end

    class Environment < Thor
      default_command :info

      desc "list", "List application environments"
      def list
        puts Moxie::Environment.all
      end

      desc "info <appname>", "Display an environment"
      def info(id=nil)
        return list if id.nil?

        safely do
          environment = Moxie::Environment.find(id)
          puts environment
        end
      end

      desc "create", "Create an application environment"
      option :app, required: true
      option :name, required: true
      def create
        safely do
          Moxie::Environment.create({
            app: options[:app],
            name: options[:name]
          })
        end
      end

      desc "delete <appname>", "Delete an environment"
      def delete(id)
        safely do
          Moxie::Environment.delete(id)
        end
      end
    end
  end


  class CLI < Thor
    desc "app <subcommand> [<args>]", "Manage applications"
    subcommand "app", Subcommands::App

    desc "environment <subcommand> [<args>]", "Manage application environments"
    subcommand "environment", Subcommands::Environment
  end
end

