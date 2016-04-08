require 'rails_helper'

describe CompoundMetricConfigurationsController, :type => :controller do
  let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

  describe 'allowed_metric_configurations' do
    let(:metric_configurations) { [
      FactoryGirl.build(:metric_configuration, reading_group_id: reading_group.id),
      FactoryGirl.build(:compound_metric_configuration, reading_group_id: reading_group.id),
      FactoryGirl.build(:hotspot_metric_configuration),
    ] }
    let(:allowed_metric_configurations) { metric_configurations[0..1] }

    before :each do
      MetricConfiguration.expects(:metric_configurations_of).with(kalibro_configuration.id).returns(metric_configurations)
    end

    it 'is expected to filter out hotspot metric configurations' do
      expect(subject.send(:allowed_metric_configurations, kalibro_configuration.id)).to eq(allowed_metric_configurations)
    end
  end

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration, reading_group_id: reading_group.id) }
      let(:metric_configurations) { [metric_configuration] }
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
        subject.expects(:allowed_metric_configurations).with(kalibro_configuration.id).returns metric_configurations

        get :new, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't own the kalibro configuration" do
      before :each do
        get :new, kalibro_configuration_id: kalibro_configuration.id
      end

      it { is_expected.to redirect_to kalibro_configurations_path id: kalibro_configuration.id }
    end
  end

  describe 'create' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration, reading_group_id: reading_group.id) }
    let!(:metric_configuration_params) { compound_metric_configuration.to_hash }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
        ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
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
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration, :with_id, reading_group_id: reading_group.id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range) }

    before :each do
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
      ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
      MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
      compound_metric_configuration.expects(:kalibro_ranges).returns([kalibro_range])

      get :show, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id.to_s, id: compound_metric_configuration.id
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'edit' do
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration, :with_id, reading_group_id: reading_group.id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the compound metric configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
          subject.expects(:metric_configuration_owner?).returns(true)
          ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
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
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration, :with_id, reading_group_id: reading_group.id) }
    # Exclude the parameters that come in the URL (as the ones in the body will always be ignored)
    let(:metric_configuration_params) { compound_metric_configuration.to_hash.except('id', 'kalibro_configuration_id', 'type') }
    # Exclude the reading group id since it is set beforehand and not in the update params
    let(:update_params) do
      params = metric_configuration_params.dup
      params['metric'] = params['metric'].except('type')
      params
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the metric configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
          ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
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
