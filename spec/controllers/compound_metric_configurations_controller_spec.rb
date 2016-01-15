require 'rails_helper'

describe CompoundMetricConfigurationsController, :type => :controller do
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
        MetricConfiguration.expects(:metric_configurations_of).with(kalibro_configuration.id).returns([metric_configuration])
        get :new, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't own the kalibro configuration" do
      before :each do
        get :new, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to redirect_to(kalibro_configurations_url(id: kalibro_configuration.id)) }
      it { is_expected.to respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration, reading_group_id: 1) }
    let!(:metric_configuration_params) { compound_metric_configuration.to_hash }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)
          Rails.cache.expects(:delete).with("#{kalibro_configuration.id}_tree_metric_configurations")
          Rails.cache.expects(:delete).with("#{kalibro_configuration.id}_hotspot_metric_configurations")

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'show' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
    let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range) }

    before :each do
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
      ReadingGroup.expects(:find).with(compound_metric_configuration.reading_group_id).returns(reading_group)
      MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
      compound_metric_configuration.expects(:kalibro_ranges).returns([kalibro_range])

      get :show, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id.to_s, id: compound_metric_configuration.id
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'edit' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the compound metric configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
          subject.expects(:metric_configuration_owner?).returns(true)
          MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
          MetricConfiguration.expects(:metric_configurations_of).with(kalibro_configuration.id).returns([compound_metric_configuration])
          get :edit, id: compound_metric_configuration.id, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the compound metric configuration' do
        before do
          get :edit, id: compound_metric_configuration.id, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id.to_s
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: kalibro_configuration.id)) }
        it { is_expected.to respond_with(:redirect) }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: compound_metric_configuration.id, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
    # Exclude the parameters that come in the URL (as the ones in the body will always be ignored)
    let(:metric_configuration_params) { compound_metric_configuration.to_hash.except('id', 'kalibro_configuration_id', 'type') }
    # Exclude the reading group id since it is set beforehand and not in the update params
    let(:update_params) do
      params = metric_configuration_params.except('reading_group_id')
      params['metric'].except!('type')
      params
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the metric configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
          MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
          subject.expects(:metric_configuration_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            MetricConfiguration.any_instance.expects(:update).with(update_params).returns(true)
            Rails.cache.expects(:delete).with("#{kalibro_configuration.id}_tree_metric_configurations")
            Rails.cache.expects(:delete).with("#{kalibro_configuration.id}_hotspot_metric_configurations")

            post :update, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { should redirect_to(kalibro_configuration_path(id: compound_metric_configuration.kalibro_configuration_id)) }
          it { should respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            MetricConfiguration.any_instance.expects(:update).with(update_params).returns(false)

            post :update, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the reading' do
        before :each do
          post :update, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id, metric_configuration: metric_configuration_params
        end

        it { should redirect_to kalibro_configurations_path(id: compound_metric_configuration.kalibro_configuration_id) }
      end
    end
  end
end
