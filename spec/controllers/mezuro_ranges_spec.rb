require 'spec_helper'

describe MezuroRangesController do
  describe 'new' do
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range) }
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the metric configuration' do
      before :each do
        subject.expects(:metric_configuration_owner?).returns true
        MetricConfiguration.expects(:find).with(mezuro_range.metric_configuration_id).returns(metric_configuration)
        Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([])
        get :new, mezuro_configuration_id: mezuro_configuration.id, metric_configuration_id: mezuro_range.metric_configuration_id
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the metric configuration" do
      before :each do
        get :new, mezuro_configuration_id: mezuro_configuration.id, metric_configuration_id: mezuro_range.metric_configuration_id
      end

      it { should redirect_to(mezuro_configurations_path) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:mezuro_range_params) { Hash[FactoryGirl.attributes_for(:mezuro_range).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the mezuro range' do
      before :each do
        subject.expects(:metric_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MezuroRange.any_instance.expects(:save).returns(true)

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration_id: metric_configuration.id, mezuro_range: mezuro_range_params
        end

        it { should respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MezuroRange.any_instance.expects(:save).returns(false)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
          Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([])

          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration_id: metric_configuration.id, mezuro_range: mezuro_range_params
        end

        it { should render_template(:new) }
      end
    end
  end
end
