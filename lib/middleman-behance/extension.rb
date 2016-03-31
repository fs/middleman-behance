# Require core library
require 'middleman-core'
require 'wrapper'

# Extension namespace
module Middleman
  class BehanceExtension < ::Middleman::Extension
    extend Forwardable

    def_delegator :app, :logger

    option :index_path, 'projects', 'Portfolio index path'
    option :access_token, '', 'Behance API access token'
    option :user, '', 'Behance user name or ID'

    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_configuration
      fetch_projects
    end

    # A Sitemap Manipulator
    # def manipulate_resource_list(resources)
    # end

    # helpers do
    #   def a_helper
    #   end
    # end

    private

    def fetch_projects
      @projects = BehanceWrapper
                  .new(options.access_token, options.user)
                  .projects
    end
  end
end
