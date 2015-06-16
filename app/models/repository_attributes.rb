class RepositoryAttributes < ActiveRecord::Base
  belongs_to :user
  validates :repository_id, presence: true
  validates :user, presence: true

  def repository
    Repository.find(repository_id)
  end
end
