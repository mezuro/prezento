require 'spec_helper'

describe ReadingGroupsHelper do

  describe 'reading_group_owner?' do
    before :each do
      @subject = FactoryGirl.build(:reading_group)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { helper.reading_groups_owner?(@subject.id).should be_false }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownerships = []
        @ownerships.expects(:find_by_reading_group_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:reading_group_ownerships).returns(@ownerships)
      end

      it { helper.reading_groups_owner?(@subject.id).should be_false }
    end

    context 'returns true if user is the reading_group owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:reading_group_ownership)
        @ownerships = []
        @ownerships.expects(:find_by_reading_group_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:reading_group_ownerships).returns(@ownerships)
      end

      it { helper.reading_groups_owner?(@subject.id).should be_true }
    end
  end

end