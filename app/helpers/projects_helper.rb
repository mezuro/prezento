module ProjectsHelper
  def project_owner? project_id
    user_signed_in? && !current_user.project_attributes.find_by_project_id(project_id).nil?
  end

  def project_image_html(project)
    url = project.attributes.image_url

    if url && !url.empty?
      image_tag url, size:"128x128"
    else
      "<center><i class='fa fa-file-image-o fa-5x'></i></center><br />
       #{t('no_image_available')}".html_safe
    end
  end
end