module OwnershipAuthentication
  extend ActiveSupport::Concern

  def project_owner?
    if self.kind_of?(ProjectsController)
      id = params[:id]
    elsif self.kind_of?(RepositoriesController)
      id = params[:project_id]
    else
      raise "Not supported"
    end

    check_project_ownership(id)
  end

  def repository_owner?
    check_project_ownership(params[:project_id])
  end

  def reading_group_owner?
    if self.kind_of?(ReadingGroupsController)
      id = params[:id]
    elsif self.kind_of?(ReadingsController)
      id = params[:reading_group_id]
    else
      raise "Not supported"
    end

    check_reading_group_ownership(id)
  end

  def reading_owner?
    check_reading_group_ownership(params[:reading_group_id])
  end

  def mezuro_configuration_owner?
    if self.kind_of?(MezuroConfigurationsController)
      id = params[:id]
    elsif (self.kind_of?(BaseMetricConfigurationsController))
      id = params[:mezuro_configuration_id]
    else
      raise "Not supported"
    end
    check_mezuro_configuration_ownership(id)
  end

  def metric_configuration_owner?
    check_mezuro_configuration_ownership(params[:mezuro_configuration_id])
  end


  private

  def check_project_ownership(id)
    if current_user.project_ownerships.find_by_project_id(id).nil?
      respond_to do |format|
        format.html { redirect_to projects_url, notice: "You're not allowed to do this operation" }
        format.json { head :no_content }
      end
    end

    return true
  end

  def check_reading_group_ownership(id)
    if current_user.reading_group_ownerships.find_by_reading_group_id(id).nil?
      respond_to do |format|
        format.html { redirect_to reading_group_url(id), notice: "You're not allowed to do this operation" }
        format.json { head :no_content }
      end
    end

    return true
  end

  def check_mezuro_configuration_ownership(id)
    if current_user.mezuro_configuration_ownerships.find_by_mezuro_configuration_id(id).nil?
      respond_to do |format|
        format.html { redirect_to mezuro_configurations_url(id), notice: "You're not allowed to do this operation" }
        format.json { head :no_content }
      end
    end
  end
end
