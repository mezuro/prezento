class ProjectAttributes < ActiveRecord::Base
  belongs_to :user
  
  def project
    Project.find(self.project_id)
  end
end
