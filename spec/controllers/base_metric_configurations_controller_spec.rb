require 'rails_helper'

class CleanInheritsFromBaseMetricConfigurationsController < BaseMetricConfigurationsController
  def metric_configuration; super; end
  def update_metric_configuration (new_metric_configuration); super; end
end

class InheritsFromBaseMetricConfigurationsController < BaseMetricConfigurationsController
  def new
    render :nothing => true
    super
  end

  def create
    render :nothing => true
    super
  end

  def show
    update_metric_configuration(@metric_configuration)
    super
    render :nothing => true
  end

  def metric_configuration
    @metric_configuration
  end

  def update_metric_configuration (new_metric_configuration)
    @metric_configuration = new_metric_configuration
  end

  def kalibro_ranges
    @kalibro_ranges
  end

  def reading_group
    @reading_group
  end
end


describe InheritsFromBaseMetricConfigurationsController, :type => :controller do
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

  before do
    Rails.application.routes.draw do
      resources :kalibro_configurations do
        match '/metric_configurations/choose_metric' => 'metric_configurations#choose_metric', as: :choose_metric, :via => [:get]
        resources :inherits_from_base_metric_configurations do
          match '/metric_configurations/new' => 'metric_configurations#new', as: :new_metric_configuration, :via => [:post]
          match '/metric_configurations/:id' => 'metric_configurations#update', as: :metric_configuration_update, :via => [:put]
        end
      end
    end
  end

  after do
    Rails.application.reload_routes!
  end

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
        get :new, kalibro_configuration_id: kalibro_configuration.id
      end

      it { expect(metric_configuration).not_to be_nil }
      it { is_expected.to respond_with(:success) }
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
    let!(:metric_configuration_params) { FactoryGirl.build(:metric_configuration, metric: FactoryGirl.build(:metric)).to_hash }
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }

    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the kalibro configuration' do
      before :each do
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name
        end

        it { expect(subject.metric_configuration).not_to be_nil }
        it { is_expected.to respond_with(:success) }
      end
    end
  end

  describe 'show' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
    let(:kalibro_range) { FactoryGirl.build(:kalibro_range) }

    context 'with a valid metric_configuration' do
      before :each do
        ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).returns(reading_group)
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
        metric_configuration.expects(:kalibro_ranges).returns([kalibro_range])

        get :show, kalibro_configuration_id: metric_configuration.kalibro_configuration_id.to_s, id: metric_configuration.id
      end

      it { expect(subject.kalibro_ranges).not_to be_nil}
      it { expect(subject.reading_group).not_to be_nil }
    end

    context 'with a invalid metric_configuration' do
      before :each do
        subject.expects(:metric_configuration).returns(false)
      end

      it 'should raise a NotImplementedError' do
        expect { subject.show }.to raise_error(NotImplementedError)
      end
    end
  end


  context 'with a inheritance without overrides methods' do
    subject { CleanInheritsFromBaseMetricConfigurationsController.new }

    describe 'metric_configuration' do
      it 'should raise a NotImplementedError' do
        expect { subject.metric_configuration }.to raise_error(NotImplementedError)
      end
    end

    describe 'update_metric_configuration' do
      it 'should raise a NotImplementedError' do
        expect { subject.update_metric_configuration(nil) }.to raise_error(NotImplementedError)
      end
    end
  end
end
