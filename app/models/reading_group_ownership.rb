class ReadingGroupOwnership < ActiveRecord::Base
  belongs_to :user
  validates :reading_group_id, presence: true
end
