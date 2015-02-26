require 'rails_helper'

RSpec.describe ProjectAttributes, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'methods' do
    describe 'project' do
      subject { FactoryGirl.build(:project_attributes) }
      let(:project) {FactoryGirl.build(:project_with_id)}

      before :each do
        Project.expects(:find).with(subject.project_id).returns(project)
      end

      it 'should return the project' do
        expect(subject.project).to eq(project)
      end
    end
  end
end
