# Require core library
require 'middleman-core'

# Extension namespace
module Middleman
  class BehanceExtension < ::Middleman::Extension
    extend Forwardable

    def_delegator :app, :logger

    option :index_path, 'projects', 'Portfolio index path'
    option :access_token, nil, 'Behance API access token'
    option :user, nil, 'Behance user name or ID'

    def initialize(app, options_hash = {}, &block)
      # Call super to build options from the options_hash
      super

      # Require libraries only when activated
      require 'behance'
    end

    def fetch_projects
      @projects = Behance::Client.new(access_token: options.access_token)
                                 .user_projects(options.user)
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
  end
end
