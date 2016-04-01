require 'rails_helper'

describe MetricConfigurationsController, :type => :controller do
  let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

  describe 'choose_metric' do
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when adding new metrics' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
        KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:all_names).returns([metric_collector])
        get :choose_metric, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:choose_metric) }
    end
  end

  describe 'new' do
    let!(:metric_collector) { FactoryGirl.build(:metric_collector) }
    let!(:native_metric) { FactoryGirl.build(:loc) }
    let!(:reading_groups) { [FactoryGirl.build(:reading_group)] }
    let!(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in user
    end

    context 'when the current user owns the kalibro configuration' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        ReadingGroup.expects(:public_or_owned_by_user).with(user).returns(reading_groups)
        subject.expects(:kalibro_configuration_owner?).returns true
        KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
        metric_collector.expects(:find_metric_by_name).with(native_metric.name).returns(native_metric)

        get :new, kalibro_configuration_id: kalibro_configuration.id, metric_name: native_metric.name, metric_collector_name: metric_collector.name
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't own the kalibro configuration" do
      before :each do
        post :new, kalibro_configuration_id: kalibro_configuration.id, metric_name: "Lines of Code", metric_collector_name: metric_collector.name
      end

      it { is_expected.to redirect_to kalibro_configurations_path id: kalibro_configuration.id }
    end
  end

  describe 'create' do
    let!(:metric_configuration) { FactoryGirl.build(:metric_configuration, reading_group_id: reading_group.id) }
    let(:metric_configuration_params) { metric_configuration.to_hash }
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the metric configuration' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid metric' do
        before :each do
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_name).with(metric_configuration.metric.name).returns(metric_configuration.metric)
          ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
        end

        context 'with valid fields' do
          before :each do
            MetricConfiguration.any_instance.expects(:save).returns(true)

            post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_name: metric_configuration.metric.name
          end

          it { is_expected.to respond_with(:redirect) }
        end

        context 'with invalid fields' do
          before :each do
            MetricConfiguration.any_instance.expects(:save).returns(false)

            post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_name: metric_configuration.metric.name
          end

          it { is_expected.to render_template(:new) }
        end
      end

      context 'with invalid metric collector, metric or metric type' do
        let(:invalid_metric) { FactoryGirl.build(:hotspot_metric) }

        before :each do
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_name).with(metric_configuration.metric.name).returns(invalid_metric)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_name: metric_configuration.metric.name
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'show' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration, :with_id, reading_group_id: reading_group.id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range) }

    before :each do
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
    end

    context 'with a valid metric configuration instance' do
      before :each do
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
      end

      context 'with valid parameters' do
        before :each do
          ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).returns(reading_group)
          metric_configuration.expects(:kalibro_ranges).returns([kalibro_range])

          get :show, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s, id: metric_configuration.id
        end

        it { is_expected.to render_template(:show) }
      end

      context 'with invalid parameters' do
        before :each do
          ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).raises(Likeno::Errors::RecordNotFound)

          get :show, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s, id: metric_configuration.id
        end

        it { is_expected.to redirect_to(kalibro_configuration_path(kalibro_configuration.id)) }
      end
    end

    context 'with an invalid metric configuration instance' do
      let!(:invalid_metric_configuration) { FactoryGirl.build(:metric_configuration, reading_group_id: reading_group.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id + 1) }

      before :each do
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(invalid_metric_configuration)
      end

      context 'with valid parameters' do
        before :each do
          get :show, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s, id: metric_configuration.id
        end

        it { is_expected.to respond_with(:not_found) }
      end
    end
  end

  describe 'edit' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration, :with_id, reading_group_id: reading_group.id) }
    let!(:reading_groups) { [FactoryGirl.build(:reading_group)] }
    let!(:user) { FactoryGirl.create(:user) }

    context 'with a User logged in' do
      before do
        sign_in user
      end

      context 'when the user owns the metric configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
          ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
          ReadingGroup.expects(:public_or_owned_by_user).with(user).returns(reading_groups)
          subject.expects(:metric_configuration_owner?).returns(true)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

          get :edit, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the metric configuration' do
        before :each do
          get :edit, id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id)) }
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
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id, reading_group_id: reading_group.id) }
    let(:metric_configuration_params) { metric_configuration.to_hash.except('id', 'metric')  }
    let(:update_params) { metric_configuration_params.except('kalibro_configuration_id') }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the given metric exists' do
        let!(:metric_collector) { mock('metric_collector') }

        before :each do
          metric_collector.expects(:find_metric_by_code).with(metric_configuration.metric.code).returns(metric_configuration.metric)

          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).
            with(metric_configuration.metric.metric_collector_name).
            returns(metric_collector)
        end

        context 'and the user owns the metric configuration' do
          before :each do
            KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
            subject.expects(:metric_configuration_owner?).returns true
            ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
          end

          context 'with valid fields' do
            before :each do
              MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
              MetricConfiguration.any_instance.expects(:update).with(update_params).returns(true)

              post :update,
                kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id,
                metric_configuration: metric_configuration_params,
                metric_collector_name: metric_configuration.metric.metric_collector_name,
                metric_code: metric_configuration.metric.code
            end

            it { is_expected.to redirect_to(kalibro_configuration_path(id: metric_configuration.kalibro_configuration_id)) }
            it { is_expected.to respond_with(:redirect) }
          end

          context 'with an invalid field' do
            before :each do
              MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
              MetricConfiguration.any_instance.expects(:update).with(update_params).returns(false)

              post :update,
                kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id,
                metric_configuration: metric_configuration_params,
                metric_collector_name: metric_configuration.metric.metric_collector_name,
                metric_code: metric_configuration.metric.code
            end

            it { is_expected.to render_template(:edit) }
          end
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
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
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
