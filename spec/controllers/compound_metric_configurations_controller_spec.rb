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
    let!(:metric_configuration_params) { FactoryGirl.build(:metric_configuration).to_hash }
    let!(:metric_params) { FactoryGirl.build(:metric).to_hash }
    let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }

    before do
      sign_in FactoryGirl.create(:user)
      metric_configuration_params["metric"] = metric_params
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          MetricConfiguration.expects(:metric_configurations_of).with(kalibro_configuration.id).returns([compound_metric_configuration])
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
    let(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:compound_metric_configuration_with_id).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

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
            MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(true)

            post :update, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id, metric_configuration: metric_configuration_params
          end

          it { should redirect_to(kalibro_configuration_path(id: compound_metric_configuration.kalibro_configuration_id)) }
          it { should respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            MetricConfiguration.expects(:find).with(compound_metric_configuration.id).returns(compound_metric_configuration)
            MetricConfiguration.expects(:metric_configurations_of).with(kalibro_configuration.id).returns([compound_metric_configuration])
            MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(false)

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
