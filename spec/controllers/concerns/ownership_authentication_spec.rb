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

    context 'Not MezuroConfigurationsController nor MetricConfigurationsController' do
      let!(:projects_controller) { ProjectsController.new }

      before do
        projects_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { projects_controller.mezuro_configuration_owner? }.to raise_error("Not supported")
      end
    end
  end
end
