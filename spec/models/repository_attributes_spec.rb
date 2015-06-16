require 'rails_helper'

RSpec.describe RepositoryAttributes, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:repository_id) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
