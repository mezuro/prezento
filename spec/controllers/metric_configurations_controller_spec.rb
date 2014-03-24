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
        KalibroGatekeeperClient::Entities::BaseTool.expects(:all).returns([base_tool])
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
        KalibroGatekeeperClient::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)
        post :new, mezuro_configuration_id: mezuro_configuration.id, metric_name: "Lines of Code", base_tool_name: base_tool.name
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the mezuro configuration" do
      before :each do
        post :new, mezuro_configuration_id: mezuro_configuration.id, metric_name: "Lines of Code", base_tool_name: base_tool.name
      end

      it { should redirect_to(mezuro_configurations_url(mezuro_configuration.id)) }
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

    context 'when the current user owns the metric configuration' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)
          KalibroGatekeeperClient::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params, base_tool_name: base_tool.name
        end

        it { should respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          KalibroGatekeeperClient::Entities::BaseTool.expects(:find_by_name).with(base_tool.name).returns(base_tool)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params, base_tool_name: base_tool.name
        end

        it { should render_template(:new) }
      end
    end
  end
  
  describe 'show' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:reading_group) { FactoryGirl.build(:reading_group) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range) }

    before :each do
      ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).returns(reading_group)
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
      MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([mezuro_range])

      get :show, mezuro_configuration_id: metric_configuration.configuration_id.to_s, id: metric_configuration.id
    end

    it { should render_template(:show) }
  end

  describe 'edit' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          MetricConfiguration.expects(:find).at_least_once.with(metric_configuration.id).returns(metric_configuration)
          get :edit, id: metric_configuration.id, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

        it { should render_template(:edit) }
      end

      context 'when the user does not own the metric configuration' do
        before do
          get :edit, id: metric_configuration.id, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

        it { should redirect_to(mezuro_configurations_path(metric_configuration.configuration_id)) }
        it { should respond_with(:redirect) }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: metric_configuration.id, mezuro_configuration_id: metric_configuration.configuration_id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            MetricConfiguration.expects(:find).at_least_once.with(metric_configuration.id).returns(metric_configuration)
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(true)

            post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { should redirect_to(mezuro_configuration_path(metric_configuration.configuration_id)) }
          it { should respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            MetricConfiguration.expects(:find).at_least_once.with(metric_configuration.id).returns(metric_configuration)
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(false)

            post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the reading' do
        before :each do
          post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
        end

        it { should redirect_to mezuro_configurations_path(metric_configuration.configuration_id) }
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
          delete :destroy, id: metric_configuration.id, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

         it { should redirect_to(mezuro_configurations_path(metric_configuration.configuration_id)) }
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
