# Require core library
require 'middleman-core'
require 'wrapper'

# Extension namespace
module Middleman
  class BehanceExtension < ::Middleman::Extension
    extend Forwardable

    TEMPLATES_DIR = File.expand_path('../templates/source/', __FILE__)

    def_delegator :app, :logger

    option :index_path, 'projects', 'Portfolio index path'
    option :access_token, '', 'Behance API access token'
    option :user, '', 'Behance user name or ID'
    option :project_template, 'project.html.erb', 'Single project page template'
    option :portfolio_template, 'portfolio.html.erb',
           'Portfolio index page template'

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration
      fetch_projects
    end

    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      resources << portfolio_resource

      resources
    end

    private

    def fetch_projects
      @projects = BehanceWrapper
                  .new(options.access_token, options.user)
                  .projects
    end

    def portfolio_resource
      Middleman::Sitemap::Resource
      .new(app.sitemap, options.index_path, source_file(:portfolio))
      .tap do |resource|
        resource.add_metadata({
          locals: {
            projects: @projects
          }
        })
      end
    end

    def source_file(type)
      path = File.join TEMPLATES_DIR, "#{type}.html.erb"
      raise "Template #{type} does not exist" if !File.exist?(path)

      path
    end
  end
end
