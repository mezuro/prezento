require "spec_helper"

describe CompoundMetricConfigurationsController do
  describe "routing" do
    it { should route(:get, '/mezuro_configurations/1/compound_metric_configurations/new').
                  to(controller: :compound_metric_configurations, action: :new, mezuro_configuration_id: "1") }
    it { should route(:get, '/mezuro_configurations/1/compound_metric_configurations').
                  to(controller: :compound_metric_configurations, action: :index, mezuro_configuration_id: "1") }
    it { should route(:post, '/mezuro_configurations/1/compound_metric_configurations').
                  to(controller: :compound_metric_configurations, action: :create, mezuro_configuration_id: "1") }
    it { should route(:get, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :show, mezuro_configuration_id: "1", id: "1") }
    it { should route(:get, '/mezuro_configurations/1/compound_metric_configurations/1/edit').
                  to(controller: :compound_metric_configurations, action: :edit, mezuro_configuration_id: "1", id: "1") }
    it { should route(:put, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :update, mezuro_configuration_id: "1", id: "1") }
    it { should_not route(:delete, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :destroy, mezuro_configuration_id: "1", id: "1") }
  end
end
