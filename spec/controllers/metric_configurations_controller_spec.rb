require 'rails_helper'

describe MetricConfigurationsController, :type => :controller do
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }
  describe 'choose_metric' do
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when adding new metrics' do
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
        KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:all_names).returns([metric_collector])
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
        get :choose_metric, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:choose_metric) }
    end
  end

  describe 'new' do
    let!(:metric_collector) { FactoryGirl.build(:metric_collector) }
    let!(:native_metric) { FactoryGirl.build(:loc) }
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro configuration' do
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
        KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
        metric_collector.expects(:find_metric_by_code).with(native_metric.code).returns(native_metric)
        post :new, kalibro_configuration_id: kalibro_configuration.id, metric_code: native_metric.code, metric_collector_name: metric_collector.name
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't own the kalibro configuration" do
      before :each do
        post :new, kalibro_configuration_id: kalibro_configuration.id, metric_name: "Lines of Code", metric_collector_name: metric_collector.name
      end

      it { is_expected.to redirect_to(kalibro_configurations_url(id: kalibro_configuration.id)) }
      it { is_expected.to respond_with(:redirect) }
    end
  end

  describe 'create' do
    let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:metric_configuration_params) { metric_configuration.to_hash }
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the metric configuration' do
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_name).with(metric_configuration.metric.name).returns(metric_configuration.metric)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_name: metric_configuration.metric.name
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_name).with(metric_configuration.metric.name).returns(metric_configuration.metric)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_name: metric_configuration.metric.name
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'show' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range) }

    before :each do
      ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).returns(reading_group)
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
      metric_configuration.expects(:kalibro_ranges).returns([kalibro_range])

      get :show, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s, id: metric_configuration.id
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'edit' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns(true)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
          get :edit, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the metric configuration' do
        before do
          get :edit, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id)) }
        it { is_expected.to respond_with(:redirect) }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:metric_configuration_params) { metric_configuration.to_hash }

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
            MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(true)

            post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { is_expected.to redirect_to(kalibro_configuration_path(id: metric_configuration.kalibro_configuration_id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(false)

            post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the reading' do
        before :each do
          post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id, metric_configuration: metric_configuration_params
        end

        it { is_expected.to redirect_to kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id) }
      end
    end
  end


  describe 'destroy' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          metric_configuration.expects(:destroy)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

          delete :destroy, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to redirect_to(kalibro_configuration_path(id: metric_configuration.kalibro_configuration_id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the configuration" do
        before :each do
          delete :destroy, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

         it { is_expected.to redirect_to(kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id)) }
         it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: metric_configuration.id, kalibro_configuration_id: kalibro_configuration.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
