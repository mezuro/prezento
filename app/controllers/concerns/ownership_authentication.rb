module OwnershipAuthentication
  extend ActiveSupport::Concern

  def check_project_ownership
    check_ownership(params[:id])
  end

  def check_repository_ownership
    check_ownership(params[:project_id])
  end

  def check_ownership(id)
    if current_user.project_ownerships.find_by_project_id(id).nil?
      respond_to do |format|
        format.html { redirect_to projects_url, notice: "You're not allowed to do this operation" }
       format.json { head :no_content }
      end
    end
  end

end
