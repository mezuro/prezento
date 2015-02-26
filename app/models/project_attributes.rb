class ProjectAttributes < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def project
    Project.find(self.project_id)
  end
end
