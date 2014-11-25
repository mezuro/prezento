require 'rails_helper'

describe User, :type => :model do
  context 'validations' do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:project_ownerships) }
    it { is_expected.to have_many(:reading_group_ownerships) }
    it { is_expected.to have_many(:mezuro_configuration_ownerships) }
  end

  describe 'methods' do
    describe 'projects' do
      subject { FactoryGirl.build(:user) }
      let(:project) {FactoryGirl.build(:project)}
      let(:project_ownership) {FactoryGirl.build(:project_ownership)}

      before :each do
        project_ownership.expects(:project).returns(project)
        subject.expects(:project_ownerships).returns([project_ownership])
      end

      it 'should return a list of projects owned by the user' do
        expect(subject.projects).to eq([project])
      end
    end
  end
end
