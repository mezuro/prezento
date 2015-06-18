class RepositoryAttributes < ActiveRecord::Base
  belongs_to :user
  validates :repository_id, presence: true
  validates :user, presence: true

  def repository
    @repository ||= Repository.find(repository_id)
  end

  def repository=(repository)
    @repository = repository
    self.repository_id = @repository ? @repository.id : nil
  end
end
