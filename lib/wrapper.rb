require 'behance'

# Initialize Behance API client
class BehanceWrapper
  def initialize(access_token = '', user = '')
    @client = Behance::Client.new access_token: access_token
    @user = user
  end

  def projects
    project_ids.map { |id| @client.project id }
  end

  private

  def project_ids
    begin
      @client.user_projects(@user).map { |project| project['id'] }
    rescue NoMethodError
      raise 'Can not fetch user projects. Please, check your Behance API access'
    end
  end
end
