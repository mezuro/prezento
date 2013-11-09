require "spec_helper"

describe UsersController do
  describe "routing" do
    it { should route(:get, '/users/1/projects').
                  to(controller: :users, action: :projects, user_id: 1) }
  end
end