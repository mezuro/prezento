require 'spec_helper'

describe ModulesController do
  describe "load_module_tree" do
    before :each do
      ModuleResult.expects(:find).with(42).returns(FactoryGirl.build(:module_result))
      request.env["HTTP_ACCEPT"] = 'application/javascript' # FIXME: there should be a better way to force JS

      post :load_module_tree, {id: 42}
    end

    it { should respond_with(:success) }
    it { should render_template(:load_module_tree) }
  end
end