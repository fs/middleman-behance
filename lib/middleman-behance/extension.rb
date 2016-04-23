# Require core library
require "middleman-core"
require "middleman-behance/wrapper"
require "middleman-behance/sitemap_resource"

# Extension namespace
module Middleman
  class BehanceExtension < ::Middleman::Extension
    extend Forwardable

    def_delegator :app, :logger

    option :pages_count, 2, "Count of pages that need to be fetched"
    option :index_path, "projects", "Portfolio index path"
    option :access_token, "", "Behance API access token"
    option :user, "", "Behance user name or ID"
    option :tags_whitelist, [], "User tags whitelist"
    option :project_template, "project.html.erb", "Single project page template"
    option :portfolio_template, "portfolio.html.erb",
      "Portfolio index page template"

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration
      fetch_projects
    end

    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      resources << ::MiddlemanBehance::SitemapResource.new(app, options.index_path, :portfolio,
        @projects, options).resource

      project_resources resources
    end

    private

    def project_resources(resources)
      @projects.each do |project|
        resources << ::MiddlemanBehance::SitemapResource.new(app,
          "#{options.index_path}/#{project['slug']}", :project, project,
          options).resource
      end

      resources
    end

    def fetch_projects
      @projects = ::MiddlemanBehance::Wrapper
                  .new(options.access_token,
                    options.user,
                    options.tags_whitelist,
                    options.pages_count)
                  .projects
    end
  end
end
