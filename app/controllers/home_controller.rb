class HomeController < ApplicationController
  def index
    @latest_projects = Project.latest(5)
  end
end
