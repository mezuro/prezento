require 'rails_helper'

describe KalibroConfigurationAttributes, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
