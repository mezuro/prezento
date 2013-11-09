require 'spec_helper'

describe UsersController do
  describe 'projects' do
    let(:user) { FactoryGirl.build(:user) }

    before :each do
      User.expects(:find).with(user.id).returns(user)

      get :projects, user_id: user.id
    end

    it { should render_template(:projects) }
  end
end
