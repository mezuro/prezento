require 'spec_helper'

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

  def mezuro_ranges
    @mezuro_ranges
  end

  def reading_group
    @reading_group
  end
end


describe InheritsFromBaseMetricConfigurationsController do
  let(:mezuro_configuration) { FactoryGirl.build(:mezuro_configuration) }

  before do
    Rails.application.routes.draw do
      resources :mezuro_configurations do
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

    context 'when the current user owns the mezuro configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
        get :new, mezuro_configuration_id: mezuro_configuration.id
      end

      it { metric_configuration.should_not be_nil }
      it { should respond_with(:success) }
    end

    context "when the current user doesn't owns the mezuro configuration" do
      before :each do
        get :new, mezuro_configuration_id: mezuro_configuration.id
      end

      it { should redirect_to(mezuro_configurations_url(mezuro_configuration.id)) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let!(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let!(:metric_params) { Hash[FactoryGirl.attributes_for(:metric).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    let(:base_tool) { FactoryGirl.build(:base_tool) }

    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the mezuro configuration' do
      before :each do
        subject.expects(:mezuro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          post :create, mezuro_configuration_id: mezuro_configuration.id, metric_configuration: metric_configuration_params, base_tool_name: base_tool.name
        end

        it { subject.metric_configuration.should_not be_nil }
        it { should respond_with(:success) }
      end
    end
  end

  describe 'show' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:reading_group) { FactoryGirl.build(:reading_group) }
    let(:mezuro_range) { FactoryGirl.build(:mezuro_range) }

    context 'with a valid metric_configuration' do
      before :each do
        ReadingGroup.expects(:find).with(metric_configuration.reading_group_id).returns(reading_group)
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
        MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([mezuro_range])

        get :show, mezuro_configuration_id: metric_configuration.configuration_id.to_s, id: metric_configuration.id
      end

      it { subject.mezuro_ranges.should_not be_nil}
      it { subject.reading_group.should_not be_nil }
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
