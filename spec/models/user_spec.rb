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
  end
end
