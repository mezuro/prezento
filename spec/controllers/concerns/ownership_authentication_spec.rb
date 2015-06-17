require 'rails_helper'

describe OwnershipAuthentication, type: :controller do
  #TODO: test other methods

  describe 'reading_group_owner?' do
    let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }

    context 'Not ReadingGroupsController nor ReadingsController' do
      let!(:projects_controller) { ProjectsController.new }

      before do
        projects_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { projects_controller.reading_group_owner? }.to raise_error("Not supported")
      end
    end

    context 'within ReadingsController' do
      let! (:readings_controller) { ReadingsController.new }

      before do
        readings_controller.params = {}
        readings_controller.params[:reading_group_id] = reading_group.id
      end

      context 'with a user logged in' do
        let! (:current_user) { FactoryGirl.create(:user) }

        before do
          readings_controller.expects(:current_user).returns(current_user)
        end

        context 'when the user owns the ReadingGroup' do
          let!(:reading_group_attributes) { FactoryGirl.build(:reading_group_attributes, {user_id: current_user.id, reading_group_id: reading_group.id}) }

          before do
            reading_group_attributes = Object.new
            reading_group_attributes.expects(:find_by_reading_group_id).with(reading_group.id).returns(reading_group_attributes)
            current_user.expects(:reading_group_attributes).returns(reading_group_attributes)
          end

          it 'should return true' do
            expect(readings_controller.reading_group_owner?).to be_truthy
          end
        end

        context 'when the user does not own the ReadingGroup' do
          before do
            reading_group_attributes = Object.new
            reading_group_attributes.expects(:find_by_reading_group_id).with(reading_group.id).returns(nil)
            current_user.expects(:reading_group_attributes).returns(reading_group_attributes)
          end

          it 'should respond' do # FIXME: this is not the best test, but it it's the closest we can do I think
            readings_controller.expects(:respond_to)

            readings_controller.reading_group_owner?
          end
        end
      end
    end
  end

  describe 'kalibro_configuration_owner?' do
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

    context 'Not KalibroConfigurationsController nor MetricConfigurationsController nor CompoundMetricConfigurationsController' do
      let!(:projects_controller) { ProjectsController.new }

      before do
        projects_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { projects_controller.kalibro_configuration_owner? }.to raise_error("Not supported")
      end
    end
  end

  describe 'project_owner?' do
    let(:project) { FactoryGirl.build(:project_with_id) }

    context 'Not ProjectsController nor RepositoriesController' do
      let!(:reading_group_controller) { ReadingGroupsController.new }

      before do
        reading_group_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { reading_group_controller.project_owner? }.to raise_error("Not supported")
      end
    end

    context 'within RepositoriesController' do
      let! (:repositories_controller) { RepositoriesController.new }

      before do
        repositories_controller.params = {}
        repositories_controller.params[:project_id] = project.id
      end

      context 'with a user logged in' do
        let! (:current_user) { FactoryGirl.create(:user) }

        before do
          repositories_controller.expects(:current_user).returns(current_user)
        end

        context 'when the user owns the Repository' do
          let!(:project_attributes) { FactoryGirl.build(:project_attributes, {user_id: current_user.id, project_id: project.id}) }

          before do
            project_attrs = Object.new
            project_attrs.expects(:find_by_project_id).with(project.id).returns(project_attributes)
            current_user.expects(:project_attributes).returns(project_attrs)
          end

          it 'should return true' do
            expect(repositories_controller.project_owner?).to be_truthy
          end
        end

        context 'when the user does not own the Repository' do
          before do
            project_attrs = Object.new
            project_attrs.expects(:find_by_project_id).with(project.id).returns(nil)
            current_user.expects(:project_attributes).returns(project_attrs)
          end

          it 'should respond' do # FIXME: this is not the best test, but it it's the closest we can do I think
            repositories_controller.expects(:respond_to)

            repositories_controller.project_owner?
          end
        end
      end
    end
  end

  describe 'repository_owner?' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'within RepositoriesController' do
      let! (:repositories_controller) { RepositoriesController.new }

      before do
        repositories_controller.params = {}
        repositories_controller.params[:id] = repository.id
      end

      context 'with a user logged in' do
        let! (:current_user) { FactoryGirl.build(:user) }

        before do
          repositories_controller.expects(:current_user).returns(current_user)
        end

        context 'when the user owns the Repository' do
          let!(:repository_attributes) { FactoryGirl.build(:repository_attributes, {user_id: current_user.id, repository_id: repository.id}) }

          before do
            repository_attrs = mock('repository_attributes')
            repository_attrs.expects(:find_by_repository_id).with(repository.id).returns(repository_attributes)
            current_user.expects(:repository_attributes).returns(repository_attrs)
          end

          it 'should return true' do
            expect(repositories_controller.repository_owner?).to be_truthy
          end
        end

        context 'when the user does not own the Repository' do
          before do
            repository_attrs = mock('repository_attributes')
            repository_attrs.expects(:find_by_repository_id).with(repository.id).returns(nil)
            current_user.expects(:repository_attributes).returns(repository_attrs)
          end

          it 'should respond' do # FIXME: this is not the best test, but it it's the closest we can do I think
            repositories_controller.expects(:respond_to)

            repositories_controller.repository_owner?
          end
        end
      end
    end
  end
end
