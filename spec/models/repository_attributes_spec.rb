require 'rails_helper'

RSpec.describe RepositoryAttributes, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:repository_id) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'methods' do
    describe 'repository' do
      subject { FactoryGirl.build(:repository_attributes) }

      it 'is expected to find the repository by id' do
        Repository.expects(:find).with(subject.repository_id).returns(subject)

        subject.repository
      end
    end
  end
end
