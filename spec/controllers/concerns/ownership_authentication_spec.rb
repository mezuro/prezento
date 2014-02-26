require 'spec_helper'

describe OwnershipAuthentication, type: :controller do
  #TODO: test other methods

  describe 'reading_group_owner?' do
    let(:reading_group) { FactoryGirl.build(:reading_group) }

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
          let!(:reading_group_ownership) { FactoryGirl.build(:reading_group_ownership, {user_id: current_user.id, reading_group_id: reading_group.id}) }

          before do
            reading_group_ownerships = Object.new
            reading_group_ownerships.expects(:find_by_reading_group_id).with(reading_group.id).returns(reading_group_ownership)
            current_user.expects(:reading_group_ownerships).returns(reading_group_ownerships)
          end

          it 'should return true' do
            readings_controller.reading_group_owner?.should be_true
          end
        end

        context 'when the user does not own the ReadingGroup' do
          before do
            reading_group_ownerships = Object.new
            reading_group_ownerships.expects(:find_by_reading_group_id).with(reading_group.id).returns(nil)
            current_user.expects(:reading_group_ownerships).returns(reading_group_ownerships)
          end

          it 'should respond' do # FIXME: this is not the best test, but it it's the closest we can do I think
            readings_controller.expects(:respond_to)

            readings_controller.reading_group_owner?
          end
        end
      end
    end
  end

  describe 'mezuro_configuration_owner?' do
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

    context 'Not MezuroConfigurationsController nor MetricConfigurationsController nor CompoundMetricConfigurationsController' do
      let!(:projects_controller) { ProjectsController.new }

      before do
        projects_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { projects_controller.mezuro_configuration_owner? }.to raise_error("Not supported")
      end
    end
  end

  describe 'project_owner?' do
    let(:project) { FactoryGirl.build(:project) }

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
          let!(:project_ownership) { FactoryGirl.build(:project_ownership, {user_id: current_user.id, project_id: project.id}) }

          before do
            project_ownerships = Object.new
            project_ownerships.expects(:find_by_project_id).with(project.id).returns(project_ownership)
            current_user.expects(:project_ownerships).returns(project_ownerships)
          end

          it 'should return true' do
            repositories_controller.project_owner?.should be_true
          end
        end

        context 'when the user does not own the Repository' do
          before do
            project_ownerships = Object.new
            project_ownerships.expects(:find_by_project_id).with(project.id).returns(nil)
            current_user.expects(:project_ownerships).returns(project_ownerships)
          end

          it 'should respond' do # FIXME: this is not the best test, but it it's the closest we can do I think
            repositories_controller.expects(:respond_to)

            repositories_controller.project_owner?
          end
        end
      end
    end
  end
end
