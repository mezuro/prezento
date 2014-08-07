require "rails_helper"

describe ModulesController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/modules/1/tree').
                  to(controller: :modules, action: :load_module_tree, id: 1) }
    it { is_expected.to route(:post, '/modules/1/metric_history').
                  to(controller: :modules, action: :metric_history, id: 1) }
  end
end