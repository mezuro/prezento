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
      let(:project) { FactoryGirl.build(:project_with_id) }
      let(:subject_params) { project.to_hash }

      before :each do
        Project.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          post :create, :project => subject_params
        end

        it 'should redirect to the show view' do
          expect(response).to redirect_to project_path(project.id)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post :create, :project => subject_params
        end

        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:project_with_id)
        @subject_params = @subject.to_hash

        Project.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        Project.any_instance.expects(:save).returns(false)

        post :create, :project => @subject_params
      end

      it { is_expected.to render_template(:new) }
    end
  end

  describe 'show' do
    let(:project) { FactoryGirl.build(:project_with_id) }
    let(:repository) { FactoryGirl.build(:repository) }

    context 'when the project exists' do
      before :each do
        Project.expects(:find).with(project.id).returns(project)
        project.expects(:repositories).returns(repository)
        get :show, :id => project.id
      end

      it { is_expected.to render_template(:show) }
    end

    context 'when the project does not exists' do
      before :each do
        Project.expects(:find).with(project.id).raises(Likeno::Errors::RecordNotFound)
      end

      context 'when the request format is known' do
        before :each do
          get :show, :id => project.id
        end

        it { is_expected.to respond_with(:not_found) }
      end

      context 'when the request format is unknown' do
        before :each do
          get :show, id: project.id, format: :txt
        end

        it { is_expected.to respond_with(:not_found) }
      end
    end

  end

  describe 'destroy' do
    before do
      @subject = FactoryGirl.build(:project_with_id)
    end

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
        @project_attributes = FactoryGirl.build(:project_attributes)
        @attributes = []
      end

      context 'when the user owns the project' do
        before :each do
          @subject.expects(:destroy)

          subject.expects(:project_owner?)

          Project.expects(:find).with(@subject.id).returns(@subject)
          delete :destroy, :id => @subject.id
        end

        it { is_expected.to redirect_to projects_path }
      end

      context "when the user doesn't own the project" do
        before :each do
          @attributes.expects(:find_by_project_id).with("#{@subject.id}").returns(nil)
          User.any_instance.expects(:project_attributes).at_least_once.returns(@attributes)

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
    subject { FactoryGirl.build(:project_with_id) }

    before :each do
      Project.expects(:public_or_owned_by_user).returns([subject])
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:project_with_id)
    end

    context 'with an User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @attribute = FactoryGirl.build(:project_attributes)
        @attributes = []
        User.any_instance.expects(:project_attributes).at_least_once.returns(@attributes)

        sign_in @user
      end

      context 'when the user owns the project' do
        before :each do
          Project.expects(:find).with(@subject.id).returns(@subject)
          @attributes.expects(:find_by_project_id).with("#{@subject.id}").returns(@attribute)

          get :edit, :id => @subject.id
        end

        it { is_expected.to render_template(:edit) }

        it 'should assign to @project the @subject' do
          expect(assigns(:project)).to eq(@subject)
        end
      end

      context 'when the user does not own the project' do
        before do
          @subject = FactoryGirl.build(:another_project)
          @attributes.expects(:find_by_project_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { is_expected.to redirect_to(projects_path)  }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
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
      @subject = FactoryGirl.build(:project_with_id)
      @subject_params = @subject.to_hash
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the project' do
        before do
          @project_attributes = FactoryGirl.build(:project_attributes)
          @attributes = []
          @attributes.expects(:find_by_project_id).with("#{@subject.id}").returns(@project_attributes)
          User.any_instance.expects(:project_attributes).at_least_once.returns(@attributes)
        end

        context 'with valid fields' do
          before :each do
            Project.expects(:find).with(@subject.id).returns(@subject)
            Project.any_instance.expects(:update).with(@subject_params).returns(true)
            @project_attributes.expects(:update).with(image_url: @subject_params[:image_url]).returns(true)
            @subject.expects(:attributes).returns(@project_attributes)
          end

          context 'rendering the show' do
            before :each do
              post :update, :id => @subject.id, :project => @subject_params
            end

            it 'should redirect to the show view' do
              expect(response).to redirect_to project_path(@subject.id)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => @subject.id, :project => @subject_params
            end

            it { is_expected.to respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            Project.expects(:find).with(@subject.id).returns(@subject)
            Project.any_instance.expects(:update).with(@subject_params).returns(false)

            post :update, :id => @subject.id, :project => @subject_params
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
