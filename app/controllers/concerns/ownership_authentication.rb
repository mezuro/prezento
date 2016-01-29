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
    check_repository_ownership(params[:id])
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

  def kalibro_configuration_owner?
    if self.kind_of?(KalibroConfigurationsController)
      id = params[:id]
    elsif (self.kind_of?(BaseMetricConfigurationsController))
      id = params[:kalibro_configuration_id]
    else
      raise "Not supported"
    end
    check_kalibro_configuration_ownership(id)
  end

  def metric_configuration_owner?
    check_kalibro_configuration_ownership(params[:kalibro_configuration_id])
  end

  private

  def check_repository_ownership(id)
    if current_user.repository_attributes.find_by_repository_id(id).nil?
      respond_to do |format|
        format.html { redirect_to projects_path, notice: t('not_allowed') }
        format.json { head :no_content }
      end
    end

    return true
  end


  def check_project_ownership(id)
    if current_user.project_attributes.find_by_project_id(id).nil?
      respond_to do |format|
        format.html { redirect_to projects_path, notice: t('not_allowed') }
        format.json { head :no_content }
      end
    end

    return true
  end

  def check_reading_group_ownership(id)
    if current_user.reading_group_attributes.find_by_reading_group_id(id).nil?
      respond_to do |format|
        format.html { redirect_to reading_group_path(id: id), notice: t('not_allowed') }
        format.json { head :no_content }
      end
    end

    return true
  end

  def check_kalibro_configuration_ownership(id)
    if current_user.kalibro_configuration_attributes.find_by_kalibro_configuration_id(id).nil?
      respond_to do |format|
        format.html { redirect_to kalibro_configurations_path(id: id), notice: t('not_allowed') }
        format.json { head :no_content }
      end
    end
  end
end
