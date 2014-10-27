class ProjectImage < ActiveRecord::Base

  belongs_to :project
  before_save :check_url

  def check_no_image
    if !self.blank?
      if self.image_url == "no-image-available.png"
        self.image_url = ""
      end
    end
  end

  def check_url
    if self.image_url.blank?
      self.image_url = "no-image-available.png"
    end
  end


end
