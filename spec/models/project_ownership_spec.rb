require 'spec_helper'

describe ProjectOwnership, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'methods' do
    describe 'project' do
      subject {FactoryGirl.build(:project_ownership)}
      let(:project) {FactoryGirl.build(:project)}

      before :each do
        Project.expects(:find).with(subject.project_id).returns(project)
      end

      it 'should return the project' do
        expect(subject.project).to eq(project)
      end
    end
  end
end
