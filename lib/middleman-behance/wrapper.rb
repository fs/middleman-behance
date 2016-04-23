require "behance"
require "slugify"

# Initialize Behance API client
module MiddlemanBehance
  class Wrapper
    PER_PAGE = 25

    def initialize(access_token = "", user = "", tags_whitelist = [], pages = 2)
      @client = Behance::Client.new access_token: access_token
      @user = user
      @tags_whitelist = tags_whitelist
      @pages = pages
      @project_ids = []
    end

    def projects
      fetch_project_ids

      @project_ids.map do |id|
        project = @client.project id
        project["slug"] = project["name"].slugify
        return project if @tags_whitelist.empty?

        project["tags"] = project["tags"] & @tags_whitelist
        project
      end
    end

    private

    def fetch_project_ids
      (1..@pages).each do |i|
        begin
          @client
            .user_projects(@user, per_page: PER_PAGE, page: i)
            .each { |project| @project_ids << project["id"] }
        rescue
          raise "Can not fetch user projects.
                 Please, check your Behance API access"
        end
      end
    end
  end
end
