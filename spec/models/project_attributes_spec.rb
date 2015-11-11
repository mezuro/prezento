require 'rails_helper'

RSpec.describe ProjectAttributes, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:project_id) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'methods' do
    let(:project) { FactoryGirl.build(:project_with_id) }
    describe 'project' do
      subject { FactoryGirl.build(:project_attributes, :bare, project_id: project.id) }
      before :each do
        Project.expects(:find).with(subject.project_id).returns(project)
      end

      it 'should return the project' do
        expect(subject.project).to eq(project)
      end
    end

    describe 'project=' do
      subject { FactoryGirl.build(:project_attributes, :bare) }

      before do
        subject.project = project
      end

      it 'is expected to set the project' do
        expect(subject.project).to eq project
      end

      it 'is expected to set the project_id' do
        expect(subject.project_id).to eq project.id
      end
    end
  end
end
