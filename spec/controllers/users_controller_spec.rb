require 'rails_helper'

describe UsersController, :type => :controller do
  describe 'projects' do
    let(:user) { FactoryGirl.build(:user, :with_id) }

    before :each do
      User.expects(:find).with(user.id).returns(user)

      get :projects, user_id: user.id
    end

    it { is_expected.to render_template(:projects) }
  end
end
