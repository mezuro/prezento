require "spec_helper"

describe ConfigurationsController do
  describe "routing" do
    it { should route(:get, '/configurations/new').
                  to(controller: :configurations, action: :new) }

    it { should route(:get, '/configurations').
                  to(controller: :configurations, action: :index) }

    it { should route(:post, '/configurations').
                  to(controller: :configurations, action: :create) }

    it { should route(:get, '/configurations/1').
                  to(controller: :configurations, action: :show, id: "1") }

    it { should route(:get, '/configurations/1/edit').
                  to(controller: :configurations, action: :edit, id: "1") }

    it { should route(:put, '/configurations/1').
                  to(controller: :configurations, action: :update, id: "1") }

    it { should route(:delete, '/configurations/1').
                  to(controller: :configurations, action: :destroy, id: "1") }
  end
end