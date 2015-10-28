require 'rails_helper'

describe ModulesController, :type => :controller do
  describe "load_module_tree" do
    before :each do
      ModuleResult.expects(:find).with(42).returns(FactoryGirl.build(:module_result))

      post :load_module_tree, id: 42, format: :js
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:load_module_tree) }
  end

  describe "metric_history" do
    let (:module_id){ 1 }
    let (:metric_name ){ FactoryGirl.build(:loc).name }
    let (:date ){ DateTime.parse("2011-10-20T18:26:43.151+00:00") }
    let (:tree_metric_result){ FactoryGirl.build(:tree_metric_result) }
    let! (:module_result){ FactoryGirl.build(:module_result) }

    before :each do
      ModuleResult.expects(:find).with(module_result.id).returns(module_result)
      subject.expire_fragment("#{module_result.id}_#{metric_name}")

      xhr :get, :metric_history, {id: module_result.id, metric_name: metric_name, module_id: module_id}
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:metric_history) }
  end
end
