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

      context 'when there are attributes' do
        let!(:project_attributes) { FactoryGirl.build(:project_attributes) }

        before :each do
          ProjectAttributes.expects(:find_by_project_id).returns(project_attributes)
        end

        it 'is expected to return the project attributes' do
          expect(subject.attributes).to eq(project_attributes)
        end
      end

      context 'when there are no attributes' do
        before :each do
          ProjectAttributes.expects(:find_by_project_id).returns(nil)
        end

        it 'is expected to return the project attributes' do
          expect(subject.attributes).to be_nil
        end
      end
    end

    describe 'destroy' do
      let!(:project) { FactoryGirl.build(:project) }

      context 'when attributes exist' do
        let!(:project_attributes) { FactoryGirl.build(:project_attributes, project_id: project.id) }
        before :each do
          KalibroClient::Entities::Processor::Project.any_instance.expects(:destroy).returns(project)
        end

        it 'is expected to be destroyed' do
          project.expects(:attributes).twice.returns(project_attributes)
          project_attributes.expects(:destroy)
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

      context 'when attributes is nil' do
        before do
          project.expects(:attributes).returns(nil)
          KalibroClient::Entities::Processor::Project.any_instance.expects(:destroy).returns(project)
        end

        it 'is expected to not try to destroy the attributes' do
          project.destroy
        end
      end
    end
  end

  describe 'class methods' do
    describe 'public_or_owned_by_user' do
      let!(:user) { FactoryGirl.build(:user, :with_id) }

      let!(:owned_private_attrs)     { FactoryGirl.build(:project_attributes, :private, user_id: user.id) }
      let!(:owned_public_attrs)      { FactoryGirl.build(:project_attributes,           user_id: user.id) }
      let!(:not_owned_private_attrs) { FactoryGirl.build(:project_attributes, :private, user_id: user.id + 1) }
      let!(:not_owned_public_attrs)  { FactoryGirl.build(:project_attributes,           user_id: user.id + 1) }

      let!(:public_attrs) { [owned_public_attrs, not_owned_public_attrs] }
      let(:public_projects) { public_attrs.map(&:project) }

      let!(:owned_or_public_attrs) { public_attrs + [owned_private_attrs] }
      let!(:owned_or_public_projects) { owned_or_public_attrs.map(&:project) }

      let(:all_projects) { owned_or_public_projects + [not_owned_private_attrs.project] }

      context 'when projects exist' do
        before :each do
          all_projects.each do |project|
            described_class.stubs(:find).with(project.id).returns(project)
          end

          ProjectAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        context 'when user is not provided' do
          it 'is expected to find all public reading groups' do
            expect(described_class.public_or_owned_by_user).to eq(public_projects)
          end
        end

        context 'when user is provided' do
          before do
            ProjectAttributes.expects(:where).with(user_id: user.id, public: false).returns([owned_private_attrs])
          end

          it 'is expected to find all public and owned reading groups' do
            expect(described_class.public_or_owned_by_user(user)).to eq(owned_or_public_projects)
          end
        end
      end

      context 'when no reading groups exist' do
        before :each do
          all_projects.each do |project|
            described_class.stubs(:find).with(project.id).raises(Likeno::Errors::RecordNotFound)
          end

          ProjectAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        it 'is expected to be empty' do
          expect(described_class.public_or_owned_by_user).to be_empty
        end
      end
    end
  end
end
