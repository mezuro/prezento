require 'uri'

class ProjectOwnership < ActiveRecord::Base
  belongs_to :user
  validates :project_id, presence: true
  validates :image_url, presence: true
  validates_format_of :image_url, with: URI::regexp

  def project
    Project.find(project_id)
  end
end
