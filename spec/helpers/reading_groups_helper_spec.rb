require 'rails_helper'

describe ReadingGroupsHelper, :type => :helper do

  describe 'reading_group_owner?' do
    before :each do
      @subject = FactoryGirl.build(:reading_group, :with_id)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { expect(helper.reading_groups_owner?(@subject.id)).to be_falsey }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownerships = []
        @ownerships.expects(:find_by_reading_group_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:reading_group_attributes).returns(@ownerships)
      end

      it { expect(helper.reading_groups_owner?(@subject.id)).to be_falsey }
    end

    context 'returns true if user is the reading_group owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:reading_group_attributes)
        @ownerships = []
        @ownerships.expects(:find_by_reading_group_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:reading_group_attributes).returns(@ownerships)
      end

      it { expect(helper.reading_groups_owner?(@subject.id)).to be_truthy }
    end
  end

end