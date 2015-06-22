class ProjectAttributes < ActiveRecord::Base
  belongs_to :user
  validates :project_id, presence: true
  validates :user, presence: true

  def project
    Project.find(self.project_id)
  end
end
