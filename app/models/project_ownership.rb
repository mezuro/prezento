#FIXME: remove this after the migration has been done and modify the migration accordingly
class ProjectOwnership < ActiveRecord::Base
  belongs_to :user
  validates :project_id, presence: true

  def project
    Project.find(project_id)
  end
end
