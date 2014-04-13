require 'spec_helper'

describe MezuroRangesController do
  let(:mezuro_range) { FactoryGirl.build(:mezuro_range, id: 1) }
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

  describe 'new' do
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

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

      it { should redirect_to(mezuro_configurations_path(mezuro_configuration.id)) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:mezuro_range_params) { Hash[FactoryGirl.attributes_for(:mezuro_range).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

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

  describe 'destroy' do
    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the metric configuration' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          mezuro_range.expects(:destroy)
          MezuroRange.expects(:find).at_least_once.with(mezuro_range.id).returns(mezuro_range)

          delete :destroy, id: mezuro_range.id.to_s, metric_configuration_id: metric_configuration.id.to_s, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

        it { should redirect_to(mezuro_configuration_metric_configuration_path(metric_configuration.configuration_id, metric_configuration.id)) }
        it { should respond_with(:redirect) }
      end

      context "when the user doesn't own the metric configuration" do
        before :each do
          delete :destroy, id: mezuro_range.id.to_s, metric_configuration_id: metric_configuration.id.to_s, mezuro_configuration_id: metric_configuration.configuration_id.to_s
        end

         it { should redirect_to(mezuro_configurations_path(metric_configuration.configuration_id)) }
         it { should respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: mezuro_range.id.to_s, metric_configuration_id: metric_configuration.id.to_s, mezuro_configuration_id: metric_configuration.configuration_id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'edit' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range, id: 1, metric_configuration_id: metric_configuration.id) }
    let(:reading) { FactoryGirl.build(:reading, group_id: metric_configuration.reading_group_id) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the mezuro range' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
          MezuroRange.expects(:find).with(mezuro_range.id).returns(mezuro_range)
          MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
          Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([reading])
          get :edit, id: mezuro_range.id, mezuro_configuration_id: metric_configuration.configuration_id, metric_configuration_id: metric_configuration.id
        end

        it { should render_template(:edit) }
      end

      context 'when the user does not own the mezuro range' do
        let!(:reading_group) { FactoryGirl.build(:reading_group, id: metric_configuration.reading_group_id) }

        before do
          get :edit, id: mezuro_range.id, mezuro_configuration_id: metric_configuration.configuration_id, metric_configuration_id: metric_configuration.id
        end

        it { should redirect_to(mezuro_configurations_url(metric_configuration.configuration_id)) }
        it { should respond_with(:redirect) }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: mezuro_range.id, mezuro_configuration_id: metric_configuration.configuration_id, metric_configuration_id: metric_configuration.id
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range, id: 1, metric_configuration_id: metric_configuration.id) }
    let(:mezuro_range_params) { Hash[FactoryGirl.attributes_for(:mezuro_range).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
    let(:reading) { FactoryGirl.build(:reading, group_id: metric_configuration.reading_group_id) }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the mezuro range' do
        before :each do
          subject.expects(:metric_configuration_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            MezuroRange.expects(:find).with(mezuro_range.id).returns(mezuro_range)
            MezuroRange.any_instance.expects(:update).with(mezuro_range_params).returns(true)

            post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: mezuro_range.id, metric_configuration_id: metric_configuration.id, mezuro_range: mezuro_range_params
          end

          it { should redirect_to(mezuro_configuration_metric_configuration_path(metric_configuration.configuration_id, metric_configuration.id)) }
          it { should respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            MezuroRange.expects(:find).with(mezuro_range.id).returns(mezuro_range)
            MezuroRange.any_instance.expects(:update).with(mezuro_range_params).returns(false)
            MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
            Reading.expects(:readings_of).with(metric_configuration.reading_group_id).returns([reading])

            post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: mezuro_range.id, metric_configuration_id: metric_configuration.id, mezuro_range: mezuro_range_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the mezuro range' do
        before :each do
          post :update, mezuro_configuration_id: metric_configuration.configuration_id, id: mezuro_range.id, metric_configuration_id: metric_configuration.id, mezuro_range: mezuro_range_params
        end

        it { should redirect_to mezuro_configurations_path(metric_configuration.configuration_id) }
      end
    end
  end
end
