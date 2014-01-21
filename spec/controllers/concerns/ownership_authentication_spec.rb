require 'spec_helper'

describe OwnershipAuthentication do
  #TODO: test other methods

  describe 'reading_group_owner?' do
    context 'Not ReadingGroupsController nor ReadingsController' do
      before do
        @projects_controller = ProjectsController.new # let doesn't work in here
        @projects_controller.extend(OwnershipAuthentication)
      end

      it 'should raise an exception' do
        expect { @projects_controller.reading_group_owner? }.to raise_error("Not supported")
      end
    end
  end
end