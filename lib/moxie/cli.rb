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
      default_command :show

      desc "index", "List applications"
      def index
        safely do
          applications = Moxie::Application.all.sort_by(&:name)
          cols = [:name, :repo]
          table = UI.table(cols, applications)
          puts table
        end
      end

      desc "show <appname>", "Display an application"
      def show(name=nil)
        return index if name.nil?

        safely do
          application = Moxie::Application.find(name)
          puts application
        end
      end

      desc "create", "Create an application"
      option :name, required: true
      option :repo, required: true
      def create
        params = {
          name: options[:name],
          repo: options[:repo]
        }
        safely do
          Moxie::Application.create(params)
        end
      end

      desc "update <appname> [options]", "update an application"
      option :repo
      def update(name)
        params = {}.merge(options)
        safely do
          Moxie::Application.update(name, params)
        end
      end

      desc "delete <appname>", "Delete an application"
      def delete(name)
        safely do
          Moxie::Application.delete(name)
        end
      end
    end
  end

  class CLI < Thor
    desc "app <subcommand> [<args>]", "Manage applications"
    subcommand "app", Subcommands::App

    desc "apps", "List applications"
    def apps
      Subcommands::App.new.index
    end

    desc "builds", "List builds"
    def builds
      safely do
        builds = Moxie::Build.all.sort_by(&:version).reverse
        cols = [:id, :app, :branch, :version, :status]
        table = UI.table(cols, builds)
        puts table
      end
    end

    desc "build <appname>", "Build application"
    option :branch, default: 'master'
    def build(appname)
      safely do
        branch = options[:branch]

        build = Moxie::Build.create({
          app: appname,
          branch: branch
        })

        workspace = "/tmp"

        # Forms a directory name like '/tmp/appname.20150130T031317'.
        repo = "#{workspace}/#{build.application.name}.#{build.version}"

        # Forms a filename like '/tmp/appname.20150130T031317.tar.gz'.
        pkg = "#{workspace}/#{build.application.name}.#{build.version}.tar.gz"

        # Create the build workspace.
        %x[mkdir -p #{workspace}]

        # Clone codebase into workspace.
        %x[git clone --branch #{build.branch} --depth=1 --single-branch #{build.repo} #{repo} >&2]

        # Delete git artifacts.
        %x[rm -rf #{repo}/.git]

        Dir.chdir(repo) do
          %x[make build]
        end

        # Zip up the codebase into a package.
        %x[tar -zcf #{pkg} -C #{repo} .]

        # Clean up local build artifacts.
        #%x[rm #{pkg}]
        #%x[rm -rf #{repo}]
      end
    end

  end
end

