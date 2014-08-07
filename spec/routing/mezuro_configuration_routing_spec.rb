require "rails_helper"

describe MezuroConfigurationsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/mezuro_configurations/new').
                  to(controller: :mezuro_configurations, action: :new) }
    it { is_expected.to route(:get, '/mezuro_configurations').
                  to(controller: :mezuro_configurations, action: :index) }
    it { is_expected.to route(:post, '/mezuro_configurations').
                  to(controller: :mezuro_configurations, action: :create) }
    it { is_expected.to route(:get, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :show, id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/edit').
                  to(controller: :mezuro_configurations, action: :edit, id: "1") }
    it { is_expected.to route(:put, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :update, id: "1") }
    it { is_expected.to route(:delete, '/mezuro_configurations/1').
                  to(controller: :mezuro_configurations, action: :destroy, id: "1") }
  end
end
