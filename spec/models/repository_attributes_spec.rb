require 'rails_helper'

RSpec.describe RepositoryAttributes, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:repository_id) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:repository_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'methods' do
    describe 'repository' do
      subject { FactoryGirl.build(:repository_attributes, repository: nil) }
      let(:repository) { FactoryGirl.build(:repository) }

      before :each do
        Repository.expects(:find).with(subject.repository_id).returns(repository)
      end

      it 'should return the repository' do
        expect(subject.repository).to eq(repository)
      end
    end

    describe 'repository=' do
      subject { FactoryGirl.build(:repository_attributes) }
      let(:repository) { FactoryGirl.build(:repository) }

      context 'when the repository is not nil' do
        it "should set the repository and it's ID correctly" do
          subject.repository = repository
          expect(subject.repository).to eq(repository)
          expect(subject.repository_id).to eq(repository.id)
        end
      end

      context 'when the repository is nil' do
        it "should unset the repository id" do
          subject.repository = nil
          expect(subject.repository_id).to be_nil
        end
      end
    end
  end
end
