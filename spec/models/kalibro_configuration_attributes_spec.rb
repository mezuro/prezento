require 'rails_helper'

describe KalibroConfigurationAttributes, :type => :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:kalibro_configuration_id) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:kalibro_configuration_id)}
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
