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

  describe "metric_history" do
    let (:module_id){ 1 }
    let (:metric_name ){ FactoryGirl.build(:loc).name }
    let (:date ){ DateTime.parse("2011-10-20T18:26:43.151+00:00") }
    let (:metric_result){ FactoryGirl.build(:metric_result) }
    let (:module_result){ FactoryGirl.build(:module_result) }

    before :each do
      module_result #TODO discover why this line is fundamental, without this line the test generates a nil object for module_result
      ModuleResult.expects(:new).at_least_once.with({id: module_result.id.to_s}).returns(module_result)
      module_result.expects(:metric_history).with(metric_name).returns({date => metric_result.value})
    end

    context "testing existence of the image in the response" do
      it "should return an image" do
        get :metric_history, id: module_result.id, metric_name: metric_name, module_id: module_id      
        response.content_type.should eq "image/png"
      end
    end

    context "testing parameter values" do
      
      before :each do
        @graphic = Gruff::Line.new(400)
        Gruff::Line.expects(:new).with(400).returns(@graphic)
      end

      it "should return two arrays, one of dates and other of values" do
        get :metric_history, id: module_result.id, metric_name: metric_name, module_id: module_id
        @graphic.maximum_value.should eq metric_result.value
        @graphic.labels.first[1].should eq date.strftime("%Y/%m/%d") 
      end
    end

    


  end 
end