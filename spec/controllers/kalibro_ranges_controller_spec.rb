require 'rails_helper'

describe KalibroRangesController, :type => :controller do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
  let(:kalibro_range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: metric_configuration.id) }

  describe 'new' do
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the metric configuration' do
      before :each do
        subject.expects(:metric_configuration_owner?).returns true
        MetricConfiguration.expects(:find).with(kalibro_range.metric_configuration_id).returns(metric_configuration)
        Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([])
        get :new, kalibro_configuration_id: kalibro_configuration.id, metric_configuration_id: kalibro_range.metric_configuration_id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't own the metric configuration" do
      before :each do
        get :new, kalibro_configuration_id: kalibro_configuration.id, metric_configuration_id: kalibro_range.metric_configuration_id
      end

      it { is_expected.to redirect_to(kalibro_configurations_path(id: kalibro_configuration.id)) }
      it { is_expected.to respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:kalibro_range_params) { kalibro_range.to_hash }
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro range' do
      before :each do
        subject.expects(:metric_configuration_owner?).returns true
      end

      context 'with valid fields and a native metric configuration' do
        before :each do
          KalibroRange.any_instance.expects(:save).returns(true)
          MetricConfiguration.expects(:find).with(kalibro_range.metric_configuration_id).returns(metric_configuration)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration_id: kalibro_range.metric_configuration_id, kalibro_range: kalibro_range_params
        end

        it { is_expected.to redirect_to(kalibro_configuration_metric_configuration_path(kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context 'with valid fields and a compound metric configuration' do
        let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
        let(:new_kalibro_range) { FactoryGirl.build(:kalibro_range, metric_configuration_id: compound_metric_configuration.id) }

        before :each do
          KalibroRange.any_instance.expects(:save).returns(true)
          MetricConfiguration.expects(:find).with(new_kalibro_range.metric_configuration_id).returns(compound_metric_configuration)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration_id: new_kalibro_range.metric_configuration_id, kalibro_range: new_kalibro_range.to_hash
        end

        it { is_expected.to redirect_to(kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          KalibroRange.any_instance.expects(:save).returns(false)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
          Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([])

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration_id: metric_configuration.id, kalibro_range: kalibro_range_params
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'destroy' do
    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          kalibro_range.expects(:destroy)
          KalibroRange.expects(:find).with(kalibro_range.id).returns(kalibro_range)
          MetricConfiguration.expects(:find).with(kalibro_range.metric_configuration_id).returns(metric_configuration)

          delete :destroy, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id
        end

        it { is_expected.to redirect_to(kalibro_configuration_metric_configuration_path(kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context 'when the user owns the compound metric configuration' do
        let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
        let(:new_kalibro_range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: compound_metric_configuration.id) }

        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          new_kalibro_range.expects(:destroy)
          KalibroRange.expects(:find).with(new_kalibro_range.id).returns(new_kalibro_range)
          MetricConfiguration.expects(:find).with(new_kalibro_range.metric_configuration_id).returns(compound_metric_configuration)

          delete :destroy, id: new_kalibro_range.id, metric_configuration_id: compound_metric_configuration.id, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id
        end

        it { is_expected.to redirect_to(kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the metric configuration" do
        before :each do
          delete :destroy, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id)) }
        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'edit' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: metric_configuration.id) }
    let(:reading) { FactoryGirl.build(:reading_with_id, reading_group_id: metric_configuration.reading_group_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the kalibro range' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          KalibroRange.expects(:find).with(kalibro_range.id).returns(kalibro_range)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
          Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([reading])
          get :edit, id: kalibro_range.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, metric_configuration_id: metric_configuration.id
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the kalibro range' do
        let!(:reading_group) { FactoryGirl.build(:reading_group, id: metric_configuration.reading_group_id) }

        before do
          get :edit, id: kalibro_range.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, metric_configuration_id: metric_configuration.id
        end

        it { is_expected.to redirect_to kalibro_configurations_path id: metric_configuration.kalibro_configuration_id }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: kalibro_range.id, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, metric_configuration_id: metric_configuration.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: metric_configuration.id) }
    let(:kalibro_range_params) { kalibro_range.to_hash }
    let(:reading) { FactoryGirl.build(:reading_with_id, reading_group_id: metric_configuration.reading_group_id) }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the kalibro range' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            KalibroRange.expects(:find).with(kalibro_range.id).returns(kalibro_range)
            KalibroRange.any_instance.expects(:update).with(kalibro_range_params).returns(true)
            MetricConfiguration.expects(:find).with(kalibro_range.metric_configuration_id).returns(metric_configuration)

            post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_range: kalibro_range_params
          end

          it { is_expected.to redirect_to(kalibro_configuration_metric_configuration_path(kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: metric_configuration.id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with valid fields and a compound metric configuration' do
          let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
          let(:new_kalibro_range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: compound_metric_configuration.id) }

          before :each do
            KalibroRange.expects(:find).with(new_kalibro_range.id).returns(new_kalibro_range)
            KalibroRange.any_instance.expects(:update).with(new_kalibro_range.to_hash).returns(true)
            MetricConfiguration.expects(:find).with(new_kalibro_range.metric_configuration_id).returns(compound_metric_configuration)

            post :update, kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: new_kalibro_range.id, metric_configuration_id: compound_metric_configuration.id, kalibro_range: new_kalibro_range.to_hash
          end

          it { is_expected.to redirect_to(kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: compound_metric_configuration.kalibro_configuration_id, id: compound_metric_configuration.id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            KalibroRange.expects(:find).with(kalibro_range.id).returns(kalibro_range)
            KalibroRange.any_instance.expects(:update).with(kalibro_range_params).returns(false)
            MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
            Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([reading])

            post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_range: kalibro_range_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the kalibro range' do
        before :each do
          post :update, kalibro_configuration_id: metric_configuration.kalibro_configuration_id, id: kalibro_range.id, metric_configuration_id: metric_configuration.id, kalibro_range: kalibro_range_params
        end

        it { is_expected.to redirect_to kalibro_configurations_path(id: metric_configuration.kalibro_configuration_id) }
      end
    end
  end
end
