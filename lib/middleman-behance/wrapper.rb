require "behance"
require "slugify"

# Initialize Behance API client
module MiddlemanBehance
  class Wrapper
    PAGES_COUNT = 2
    PER_PAGE = 25

    def initialize(access_token = "", user = "", tags_whitelist = [], pages = PAGES_COUNT)
      @client = Behance::Client.new access_token: access_token
      @user = user
      @tags_whitelist = tags_whitelist
      @pages = pages
    end

    def projects
      @projects ||= project_ids.reduce([]) do |memo, id|
        project = @client.project id
        next memo unless project

        project["slug"] = project["name"].slugify
        next memo << project if @tags_whitelist.empty?

        project["tags"] = project["tags"] & @tags_whitelist
        memo << project
      end
    end

    private

    def project_ids
      @projects_ids ||= (1..@pages).reduce([]) do |memo, i|
        projects = @client.user_projects(@user, per_page: PER_PAGE, page: i) || []
        memo + projects.map { |p| p["id"] }
      end
    end
  end
end
