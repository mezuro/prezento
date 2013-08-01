require 'spec_helper'

describe ProjectsController do

  describe 'new' do
    before :each do
      get :new
    end

    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe 'create' do

    context 'with a valid fields' do
      before :each do
        @subject = FactoryGirl.build(:project)
        @subject_params = Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

        Project.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        Project.any_instance.expects(:save).returns(true)

        post :create, :project => @subject_params
      end
      
      it 'should redirect to the show view' do
        pending("Probably incompatibility between Rails 4 and RSpec. It isn't expecting an slash at the end." ) do
          response.should redirect_to project_path(@subject)
        end
      end

      it { should respond_with(:redirect) }
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:project)
        @subject_params = Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
        
        Project.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        Project.any_instance.expects(:save).returns(false)

        post :create, :project => @subject_params
      end

      it { should render_template(:new) }
    end
  end

  describe 'show' do
    before :each do
      @subject = FactoryGirl.build(:project)
      Project.expects(:find).with(@subject.id.to_s).returns(@subject)
      get :show, :id => @subject.id
    end

    it { should render_template(:show) }
  end

  describe 'index' do
    before :each do
      @subject = FactoryGirl.build(:project)
      Project.expects(:all).returns([@subject])
      get :index
    end

    it { should render_template(:index) }
  end
end
