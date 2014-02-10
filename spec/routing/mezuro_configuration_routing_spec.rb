require "spec_helper"

describe MezuroConfigurationsController do
  describe "routing" do
    it { should route(:get, '/mezuro_configurations/new').
                  to(controller: :mezuro_configurations, action: :new) }
    it { should route(:get, '/mezuro_configurations').
                  to(controller: :mezuro_configurations, action: :index) }
    it { should route(:post, '/mezuro_configurations').
                  to(controller: :mezuro_configurations, action: :create) }
    it { should route(:get, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :show, id: "1") }
    it { should route(:get, '/mezuro_configurations/1/edit').
                  to(controller: :mezuro_configurations, action: :edit, id: "1") }
    it { should route(:put, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :update, id: "1") }
    it { should route(:delete, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :destroy, id: "1") }
  end
end
