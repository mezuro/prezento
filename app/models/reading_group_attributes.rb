class ReadingGroupAttributes < ActiveRecord::Base
  belongs_to :user
  validates :reading_group_id, presence: true, uniqueness: true

  def reading_group
    @reading_group ||= ReadingGroup.find(reading_group_id)
  end

  def reading_group=(group)
    @reading_group = group
    self.reading_group_id = group.id
  end
end
