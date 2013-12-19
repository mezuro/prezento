class ReadingGroupOwnership < ActiveRecord::Base
  belongs_to :user
  validates :reading_group_id, presence: true

  def reading_group
    ReadingGroup.find(reading_group_id)
  end
end
