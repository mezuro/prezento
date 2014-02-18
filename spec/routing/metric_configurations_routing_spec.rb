require "spec_helper"

describe MetricConfigurationsController do
  describe "routing" do
    it { should route(:post, '/mezuro_configurations/1/metric_configurations/new').
                  to(controller: :metric_configurations, action: :new, mezuro_configuration_id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations').
                  to(controller: :metric_configurations, action: :index, mezuro_configuration_id: "1") }
    it { should route(:post, '/mezuro_configurations/1/metric_configurations').
                  to(controller: :metric_configurations, action: :create, mezuro_configuration_id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :show, mezuro_configuration_id: "1", id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1/edit').
                  to(controller: :metric_configurations, action: :edit, mezuro_configuration_id: "1", id: "1") }
    it { should route(:put, '/mezuro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :update, mezuro_configuration_id: "1", id: "1") }
    it { should route(:delete, '/mezuro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :destroy, mezuro_configuration_id: "1", id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/choose_metric').
                  to(controller: :metric_configurations, action: :choose_metric, mezuro_configuration_id: "1") }
  end
end
