module ProjectsHelper
  def project_owner? project_id
    user_signed_in? && !current_user.project_ownerships.find_by_project_id(project_id).nil?
  end
end