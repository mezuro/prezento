class HomeController < ApplicationController
  def index
    @latest_projects = Project.latest(5)
    @latest_repositories = Repository.latest(5)
    @latest_configurations = KalibroConfiguration.latest(5)
  end
end
