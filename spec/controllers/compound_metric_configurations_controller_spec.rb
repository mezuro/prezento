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

      it { should redirect_to(mezuro_configurations_url) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let!(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let!(:metric_params) { Hash[FactoryGirl.attributes_for(:metric).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

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

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { should render_template(:new) }
      end
    end
  end
end
