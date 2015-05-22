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

    describe 'destroy' do
      context 'when attributes exist' do
        let!(:project) { FactoryGirl.build(:project) }
        let!(:project_attributes) { FactoryGirl.build(:project_attributes, project_id: project.id) }

        it 'should be destroyed' do
          project.expects(:attributes).twice.returns(project_attributes)
          project_attributes.expects(:destroy)
          KalibroClient::Entities::Processor::Project.any_instance.expects(:destroy).returns(project)
          project.destroy
        end

        it 'is expected to clean the attributes memoization' do
          # Call attributes once so it memoizes
          ProjectAttributes.expects(:find_by).with(project_id: project.id).returns(project_attributes)
          expect(project.attributes).to eq(project_attributes)

          # Destroying
          project.destroy

          # The expectation call will try to find the attributes on the database which should be nil since it was destroyed
          ProjectAttributes.expects(:find_by).with(project_id: project.id).returns(nil)
          expect(project.attributes).to_not eq(project_attributes)
        end
      end
    end
  end
end
