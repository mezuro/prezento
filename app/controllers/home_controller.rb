class HomeController < ApplicationController
  helper_method :latest_projects, :latest_repositories, :latest_configurations

  def latest_projects(count)
    Project.latest(count)
  end

  def latest_repositories(count)
    Repository.latest(count)
  end

  def latest_configurations(count)
    KalibroConfiguration.latest(count)
  end
end
