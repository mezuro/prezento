require "rails_helper"

describe HotspotMetricConfigurationsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/kalibro_configurations/1/hotspot_metric_configurations').
                  to(controller: :hotspot_metric_configurations, action: :create, kalibro_configuration_id: "1") }
  end
end