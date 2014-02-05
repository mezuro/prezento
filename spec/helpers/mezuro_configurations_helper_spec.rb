require 'spec_helper'

describe MezuroConfigurationsHelper do
  describe 'mezuro_configuration_owner?' do
    before :each do
      @subject = FactoryGirl.build(:mezuro_configuration)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { helper.mezuro_configuration_owner?(@subject.id).should be_false }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownerships = []
        @ownerships.expects(:find_by_mezuro_configuration_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:mezuro_configuration_ownerships).returns(@ownerships)
      end

      it { helper.mezuro_configuration_owner?(@subject.id).should be_false }
    end

    context 'returns true if user is the mezuro_configuration owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:mezuro_configuration_ownership)
        @ownerships = []
        @ownerships.expects(:find_by_mezuro_configuration_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:mezuro_configuration_ownerships).returns(@ownerships)
      end

      it { helper.mezuro_configuration_owner?(@subject.id).should be_true }
    end
  end
end