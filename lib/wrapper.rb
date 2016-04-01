require "behance"
require "slugify"

# Initialize Behance API client
class BehanceWrapper
  def initialize(access_token = "", user = "", tags_whitelist = [])
    @client = Behance::Client.new access_token: access_token
    @user = user
    @tags_whitelist = tags_whitelist
  end

  def projects
    project_ids.map do |id|
      project = @client.project id
      project["slug"] = project["name"].slugify
      return project if @tags_whitelist.empty?

      project["tags"] = project["tags"] & @tags_whitelist
      project
    end
  end

  private

  def project_ids
    @client.user_projects(@user).map { |project| project["id"] }
  rescue NoMethodError
    raise "Can not fetch user projects. Please, check your Behance API access"
  end
end
