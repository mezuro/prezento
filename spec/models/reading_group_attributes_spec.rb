require 'rails_helper'

describe ReadingGroupAttributes, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_uniqueness_of(:reading_group_id)}
  end
end
