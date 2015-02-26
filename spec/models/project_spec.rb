require 'rails_helper'

describe Project, :type => :model do
  describe 'methods' do
    describe 'latest' do
      let!(:project) { FactoryGirl.build(:project_with_id, id: 1) }
      let!(:another_project) { FactoryGirl.build(:another_project, id: 2) }
      let!(:project_attributes) { FactoryGirl.build(:project_attributes) }

      before :each do
        project.expects(:attributes).returns(project_attributes)
        another_project.expects(:attributes).returns(project_attributes)

        Project.expects(:all).returns([project, another_project])
      end

      it 'should return the two projects ordered' do
        expect(Project.latest(2)).to eq([another_project, project])
      end

      context 'when no parameter is passed' do
        it 'should return just the most recent project' do
          expect(Project.latest).to eq([another_project])
        end
      end
    end

    describe 'attributes' do
      subject { FactoryGirl.build(:project_with_id) }

      let!(:project_attributes) { FactoryGirl.build(:project_attributes) }

      before :each do
        ProjectAttributes.expects(:find_by_project_id).returns(project_attributes)
      end

      it 'is expected to return the project attributes' do
        expect(subject.attributes).to eq(project_attributes)
      end
    end
  end
end
