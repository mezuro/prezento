require 'rails_helper'

describe ReadingGroupOwnership, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
