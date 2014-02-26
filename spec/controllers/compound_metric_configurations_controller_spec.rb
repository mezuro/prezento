require 'spec_helper'

describe CompoundMetricConfigurationsController do
  let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the mezuro configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
        MetricConfiguration.expects(:metric_configurations_of).with(mezuro_configuration.id).returns([metric_configuration])
        get :new, mezuro_configuration_id: mezuro_configuration.id
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the mezuro configuration" do
      before :each do
        get :new, mezuro_configuration_id: mezuro_configuration.id
      end

      it { should redirect_to(mezuro_configurations_url(mezuro_configuration.id)) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let!(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let!(:metric_params) { Hash[FactoryGirl.attributes_for(:metric).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }

    before do
      sign_in FactoryGirl.create(:user)
      metric_configuration_params["metric"] = metric_params
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { should respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          MetricConfiguration.expects(:metric_configurations_of).with(mezuro_configuration.id).returns([compound_metric_configuration])
          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { should render_template(:new) }
      end
    end
  end

  describe 'show' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }
    let(:reading_group) { FactoryGirl.build(:reading_group) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range) }

    before :each do
      ReadingGroup.expects(:find).with(compound_metric_configuration.reading_group_id).returns(reading_group)
      MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
      MezuroRange.expects(:ranges_of).with(compound_metric_configuration.id).returns([mezuro_range])

      get :show, mezuro_configuration_id: compound_metric_configuration.configuration_id.to_s, id: compound_metric_configuration.id
    end

    it { should render_template(:show) }
  end

  describe 'edit' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the compound metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns(true)
          MetricConfiguration.expects(:find).at_least_once.with(compound_metric_configuration.id).returns(compound_metric_configuration)
          MetricConfiguration.expects(:metric_configurations_of).with(mezuro_configuration.id).returns([compound_metric_configuration])
          get :edit, id: compound_metric_configuration.id, mezuro_configuration_id: compound_metric_configuration.configuration_id.to_s
        end

        it { should render_template(:edit) }
      end

      context 'when the user does not own the compound metric configuration' do
        before do
          get :edit, id: compound_metric_configuration.id, mezuro_configuration_id: compound_metric_configuration.configuration_id.to_s
        end

        it { should redirect_to(mezuro_configurations_path(mezuro_configuration.id)) }
        it { should respond_with(:redirect) }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: compound_metric_configuration.id, mezuro_configuration_id: compound_metric_configuration.configuration_id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end
end
