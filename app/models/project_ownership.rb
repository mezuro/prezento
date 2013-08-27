class ProjectOwnership < ActiveRecord::Base
  belongs_to :user
  validates :project_id, presence: true
end
