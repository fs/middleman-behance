# Require core library
require 'middleman-core'
require 'wrapper'
require 'sitemap_resource'

# Extension namespace
module Middleman
  class BehanceExtension < ::Middleman::Extension
    extend Forwardable

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
      resources << SitemapResource.new(app, options.index_path, :portfolio,
                                       @projects, options).resource

      @projects.each do |project|
        resources << SitemapResource
                     .new(app,
                     "#{options.index_path}/#{project['slug']}",
                     :project, project, options).resource
      end

      resources
    end

    private

    def fetch_projects
      @projects = BehanceWrapper
                  .new(options.access_token, options.user)
                  .projects
    end
  end
end
