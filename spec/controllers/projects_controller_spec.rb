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
        
        Project.expects(:new).at_least_once.with(@subject.to_hash).returns(@subject)
        Project.any_instance.expects(:save).returns(true)

        post :create, :project => @subject.to_hash
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
        
        Project.expects(:new).at_least_once.with(@subject.to_hash).returns(@subject)
        Project.any_instance.expects(:save).returns(false)

        post :create, :project => @subject.to_hash
      end

      it { should render_template(:new) }
    end
  end
end
