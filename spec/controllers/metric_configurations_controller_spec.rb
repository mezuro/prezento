require 'spec_helper'

describe MetricConfigurationsController do
  let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }
  describe 'choose_metric' do
    let(:base_tool) { FactoryGirl.build(:base_tool) }
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when adding new metrics' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
        KalibroGem::Entities::BaseTool.expects(:all).returns([base_tool])
        get :choose_metric, mezuro_configuration_id: mezuro_configuration.id
      end

      it { should respond_with(:success) }
      it { should render_template(:choose_metric) }
    end
  end

  describe 'new' do
    let(:base_tool) { FactoryGirl.build(:base_tool) }
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the mezuro configuration' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
        KalibroGem::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)
        get :new, mezuro_configuration_id: mezuro_configuration.id, metric_name: "Lines of Code", base_tool_name: base_tool.name
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the mezuro configuration" do
      before :each do
        get :new, mezuro_configuration_id: mezuro_configuration.id, metric_name: "Lines of Code", base_tool_name: base_tool.name
      end

      it { should redirect_to(mezuro_configurations_url) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }
    let(:base_tool) { FactoryGirl.build(:base_tool) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)
          KalibroGem::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params, base_tool_name: base_tool.name
        end

        it { should respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          KalibroGem::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params, base_tool_name: base_tool.name
        end

        it { should render_template(:new) }
      end
    end
  end

  describe 'destroy' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          metric_configuration.expects(:destroy)
          MetricConfiguration.expects(:find).at_least_once.with(metric_configuration.id).returns(metric_configuration)

          delete :destroy, id: metric_configuration.id, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

        it { should redirect_to(mezuro_configuration_path(metric_configuration.configuration_id)) }
        it { should respond_with(:redirect) }
      end

      context "when the user doesn't own the configuration" do
        before :each do
          MetricConfiguration.expects(:find).at_least_once.with(metric_configuration.id).returns(metric_configuration)

          delete :destroy, id: metric_configuration.id, mezuro_configuration_id: mezuro_configuration.id.to_s
        end

         it { should redirect_to(mezuro_configurations_path) }
         it { should respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: metric_configuration.id, mezuro_configuration_id: mezuro_configuration.id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end
end
