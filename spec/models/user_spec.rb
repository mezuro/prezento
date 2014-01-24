require 'spec_helper'

describe User do
  context 'validations' do
    subject { FactoryGirl.build(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { should have_many(:project_ownerships) }
    it { should have_many(:reading_group_ownerships) }
    it { should have_many(:mezuro_configuration_ownerships) }
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
        subject.projects.should eq([project])
      end
    end

    describe 'reading_groups' do
      subject { FactoryGirl.build(:user) }
      let(:reading_group) {FactoryGirl.build(:reading_group)}
      let(:reading_group_ownership) {FactoryGirl.build(:reading_group_ownership)}

      before :each do
        reading_group_ownership.expects(:reading_group).returns(reading_group)
        subject.expects(:reading_group_ownerships).returns([reading_group_ownership])
      end

      it 'should return a list of reading groups owned by the user' do
        subject.reading_groups.should eq([reading_group])
      end
    end

    describe 'mezuro_configurations' do
      subject { FactoryGirl.build(:user) }
      let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }
      let(:mezuro_configuration_ownership) { FactoryGirl.build(:mezuro_configuration_ownership) }

      before :each do
        mezuro_configuration_ownership.expects(:mezuro_configuration).returns(mezuro_configuration)
        subject.expects(:mezuro_configuration_ownerships).returns([mezuro_configuration_ownership])
      end

      it 'should return a list of mezuro configurations owned by the user' do
        subject.mezuro_configurations.should eq([mezuro_configuration])
      end
    end
  end
end
