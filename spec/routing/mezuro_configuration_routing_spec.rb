require "rails_helper"

describe KalibroConfigurationsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/kalibro_configurations/new').
                  to(controller: :kalibro_configurations, action: :new) }
    it { is_expected.to route(:get, '/kalibro_configurations').
                  to(controller: :kalibro_configurations, action: :index) }
    it { is_expected.to route(:post, '/kalibro_configurations').
                  to(controller: :kalibro_configurations, action: :create) }
    it { is_expected.to route(:get, '/kalibro_configurations/1').
                  to(controller: :kalibro_configurations, action: :show, id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/edit').
                  to(controller: :kalibro_configurations, action: :edit, id: "1") }
    it { is_expected.to route(:put, '/kalibro_configurations/1').
                  to(controller: :kalibro_configurations, action: :update, id: "1") }
    it { is_expected.to route(:delete, '/kalibro_configurations/1').
                  to(controller: :kalibro_configurations, action: :destroy, id: "1") }
  end
end
