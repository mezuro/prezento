require 'spec_helper'

describe ProjectOwnership do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'methods' do
    describe 'project' do
      subject {FactoryGirl.build(:project_ownership)}
      let(:project) {FactoryGirl.build(:project)}

      before :each do
        Project.expects(:find).with(subject.project_id).returns(project)
      end

      it 'should return the project' do
        subject.project.should eq(project)
      end
    end
  end
end
