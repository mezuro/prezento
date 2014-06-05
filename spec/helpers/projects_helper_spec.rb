require 'spec_helper'

describe ProjectsHelper, :type => :helper do

  describe 'project_owner?' do
    before :each do
      @subject = FactoryGirl.build(:project)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { expect(helper.project_owner?(@subject.id)).to be_falsey }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownerships = []
        @ownerships.expects(:find_by_project_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:project_ownerships).returns(@ownerships)
      end

      it { expect(helper.project_owner?(@subject.id)).to be_falsey }
    end

    context 'returns true if user is the project owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:project_ownership)
        @ownerships = []
        @ownerships.expects(:find_by_project_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:project_ownerships).returns(@ownerships)
      end

      it { expect(helper.project_owner?(@subject.id)).to be_truthy }
    end
  end

end