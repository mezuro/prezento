require 'rails_helper'

describe User, :type => :model do
  context 'validations' do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:project_attributes).dependent(:destroy) }
    it { is_expected.to have_many(:reading_group_attributes).dependent(:destroy) }
    it { is_expected.to have_many(:kalibro_configuration_attributes).dependent(:destroy) }
    it { is_expected.to have_many(:repository_attributes).dependent(:destroy) }
  end

  describe 'methods' do
    describe 'projects' do
      subject { FactoryGirl.build(:user) }
      let(:project) {FactoryGirl.build(:project_with_id)}
      let(:project_attributes) {FactoryGirl.build(:project_attributes)}

      before :each do
        project_attributes.expects(:project).returns(project)
        subject.expects(:project_attributes).returns([project_attributes])
      end

      it 'should return a list of projects owned by the user' do
        expect(subject.projects).to eq([project])
      end
    end
  end
end
