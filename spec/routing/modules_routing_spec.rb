require "spec_helper"

describe ModulesController do
  describe "routing" do
    it { should route(:post, '/projects/1/repositories/42/modules/24').
                  to(controller: :modules, action: :load_tree, project_id: 1, id: 42, module_result_id: 24) }
    it { should route(:get, '/modules/metric_history').
                  to(controller: :modules, action: :metric_history) }
  end
end