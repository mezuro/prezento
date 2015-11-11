class ProjectAttributes < ActiveRecord::Base
  belongs_to :user
  validates :project_id, presence: true
  validates :user, presence: true

  def project
    @project ||= Project.find(project_id)
  end

  def project=(project)
    @project = project
    self.project_id = project.id
  end
end
