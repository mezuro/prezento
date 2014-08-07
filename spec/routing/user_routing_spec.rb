require "rails_helper"

describe UsersController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/users/1/projects').
                  to(controller: :users, action: :projects, user_id: 1) }
  end
end