require 'rails_helper'

describe ProjectsController, :type => :controller do

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
      get :new
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe 'create' do
    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'with valid fields' do
	    let(:project) { FactoryGirl.build(:project) }
      let(:project_ownership){ FactoryGirl.build(:project_ownership) }
	    let(:subject_params) { Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

     	before :each do
        Project.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          Project.expects(:exists?).returns(true)

          post :create, :project => subject_params, :image_url => project_ownership.image_url
        end

        it 'should redirect to the show view' do
          expect(response).to redirect_to project_path(project)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post :create, :project => subject_params, :image_url => project_ownership.image_url
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid ownership' do
        let(:ownerships) {[]}

        before :each do
          User.any_instance.expects(:project_ownerships).at_least_once.returns(ownerships)
          ownerships.expects(:new).returns(project_ownership)
          project_ownership.expects(:save).returns(false)

          post :create, :project => subject_params, :image_url => project_ownership.image_url
        end

        it { should render_template(:new) }
      end
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:project)
        @subject_params = Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

        Project.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        Project.any_instance.expects(:save).returns(false)

        post :create, :project => @subject_params
      end

      it { is_expected.to render_template(:new) }
    end
  end

  describe 'show' do
  	subject { FactoryGirl.build(:project) }
  	let(:repository) { FactoryGirl.build(:repository) }
    before :each do
      Project.expects(:find).with(subject.id.to_s).returns(subject)
      subject.expects(:repositories).returns(repository)
      get :show, :id => subject.id
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'destroy' do
    before do
      @subject = FactoryGirl.build(:project)
    end

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:project_ownership)
        @ownerships = []

      end

      context 'when the user owns the project' do
        before :each do
          @ownership.expects(:destroy)
          @subject.expects(:destroy)

          #Those two mocks looks the same but they are necessary since params[:id] is a String and @project.id is an Integer :(
          @ownerships.expects(:find_by_project_id).with("#{@subject.id}").returns(@ownership)
          @ownerships.expects(:find_by_project_id).with(@subject.id).returns(@ownership)

          User.any_instance.expects(:project_ownerships).at_least_once.returns(@ownerships)

          Project.expects(:find).with(@subject.id.to_s).returns(@subject)
          delete :destroy, :id => @subject.id
        end

        it 'should redirect to the projects page' do
          expect(response).to redirect_to projects_url
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the project" do
        before :each do
          @ownerships.expects(:find_by_project_id).with("#{@subject.id}").returns(nil)
          User.any_instance.expects(:project_ownerships).at_least_once.returns(@ownerships)

          delete :destroy, :id => @subject.id
        end

         it { is_expected.to redirect_to(projects_path)  }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, :id => @subject.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'index' do
    before :each do
      @subject = FactoryGirl.build(:project)
      Project.expects(:all).returns([@subject])
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:project)
    end

    context 'with an User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:project_ownership)
        @ownerships = []

        User.any_instance.expects(:project_ownerships).at_least_once.returns(@ownerships)

        sign_in @user
      end

      context 'when the user owns the project' do
        before :each do
          Project.expects(:find).with(@subject.id.to_s).returns(@subject)
          @ownerships.expects(:find_by_project_id).with("#{@subject.id}").returns(@ownership)
          get :edit, :id => @subject.id
        end

        it { is_expected.to render_template(:edit) }

        it 'should assign to @project the @subject' do
          @subject.expects(:ownership).returns(@ownership)
          expect(assigns(:project)).to eq(@subject)
          expect(assigns(:project).ownership.image_url).to eq(@ownership.image_url)
        end
      end

      context 'when the user does not own the project' do
        before do
          @subject = FactoryGirl.build(:another_project)
          @ownerships.expects(:find_by_project_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { is_expected.to redirect_to(projects_path)  }
        it { is_expected.to set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, :id => @subject.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    before do
      @subject = FactoryGirl.build(:project)
      @subject_params = Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the project' do
        before do
          @ownership = FactoryGirl.build(:project_ownership)
          @ownerships = []

          @ownerships.expects(:find_by_project_id).with("#{@subject.id}").returns(@ownership)
          User.any_instance.expects(:project_ownerships).at_least_once.returns(@ownerships)
        end

        context 'with valid fields' do
          before :each do
            @ownership.expects(:update).with(image_url: @ownership.image_url).returns(true)
            Project.expects(:find).with(@subject.id.to_s).returns(@subject)
            Project.any_instance.expects(:update).with(@subject_params).returns(true)
            Project.any_instance.expects(:ownership).returns(@ownership)
          end

          context 'rendering the show' do
            before :each do
              Project.expects(:exists?).returns(true)
              post :update, :id => @subject.id, :project => @subject_params, :image_url => @ownership.image_url
            end

            it 'should redirect to the show view' do
              expect(response).to redirect_to project_path(@subject)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => @subject.id, :project => @subject_params, :image_url => @ownership.image_url
            end

            it { is_expected.to respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            Project.expects(:find).with(@subject.id.to_s).returns(@subject)
            Project.any_instance.expects(:update).with(@subject_params).returns(false)
            post :update, :id => @subject.id, :project => @subject_params, :image_url => @ownership.image_url
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the project' do
        before :each do
          post :update, :id => @subject.id, :project => @subject_params
        end

        it { is_expected.to redirect_to projects_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, :id => @subject.id, :project => @subject_params
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
