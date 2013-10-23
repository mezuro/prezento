require 'spec_helper'

describe RepositoriesController do
  let(:project) { FactoryGirl.build(:project) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the project' do
      before :each do
        Repository.expects(:repository_types).returns([])
        subject.expects(:check_repository_ownership).returns true

        get :new, project_id: project.id.to_s
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the project" do
      before :each do
        get :new, project_id: project.id.to_s
      end

      it { should redirect_to(projects_url) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let (:repository) { FactoryGirl.build(:repository, project_id: project.id) }
    let(:repository_params) { Hash[FactoryGirl.attributes_for(:repository).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the project' do
      before :each do
        subject.expects(:check_repository_ownership).returns true
      end

      context 'with valid fields' do
        before :each do
          Repository.any_instance.expects(:save).returns(true)
          Repository.any_instance.expects(:process)
          Repository.any_instance.expects(:persisted?).at_least_once.returns(true)

          post :create, project_id: project.id, repository: repository_params
        end

        it { should redirect_to(project_path(repository.project_id)) }
        it { should respond_with(:redirect) }
      end

      context 'with an invalid field' do
        before :each do
          Repository.any_instance.expects(:save).returns(false)
          Repository.any_instance.expects(:persisted?).at_least_once.returns(false)

          post :create, project_id: project.id.to_s, repository: repository_params
        end

        it { should render_template(:new) }
      end
    end

    context "when the current user doesn't owns the project " do
      before :each do
        post :create, project_id: project.id, repository: repository_params
      end

      it { should redirect_to(projects_url) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'show' do
    let(:repository) { FactoryGirl.build(:repository)}
    before :each do
      repository.expects(:last_processing).returns(FactoryGirl.build(:processing))
      KalibroEntities::Entities::Configuration.expects(:find).with(repository.id).returns(FactoryGirl.build(:configuration))
      Repository.expects(:find).with(repository.id).returns(repository)

      get :show, id: repository.id.to_s, project_id: project.id.to_s
    end

    it { should render_template(:show) }
  end

  describe 'destroy' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the project' do
        before :each do
          subject.expects(:check_repository_ownership).returns true
          repository.expects(:destroy)
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

          delete :destroy, id: repository.id, project_id: project.id.to_s
        end

        it { should redirect_to(project_path(repository.project_id)) }
        it { should respond_with(:redirect) }
      end

      context "when the user doesn't own the project" do
        before :each do
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

          delete :destroy, :id => repository.id, project_id: project.id.to_s
        end

         it { should redirect_to(projects_url) }
         it { should respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, :id => repository.id, project_id: project.id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end

  pending "Work in progress" do
  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:repository)
    end

    context 'with an User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:repository_ownership)
        @ownerships = []

        User.any_instance.expects(:repository_ownerships).at_least_once.returns(@ownerships)

        sign_in @user
      end

      context 'when the user owns the repository' do
        before :each do
          Repository.expects(:find).with(@subject.id.to_s).returns(@subject)
          @ownerships.expects(:find_by_repository_id).with("#{@subject.id}").returns(@ownership)

          get :edit, :id => @subject.id
        end

        it { should render_template(:edit) }

        it 'should assign to @repository the @subject' do
          assigns(:repository).should eq(@subject)
        end
      end

      context 'when the user does not own the repository' do
        before do
          @subject = FactoryGirl.build(:another_repository)
          @ownerships.expects(:find_by_repository_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { should redirect_to(repositories_path)  }

        it 'should set the flash' do
          pending("This ShouldaMatcher test is not compatible yet with Rails 4") do
            should set_the_flash[:notice].to("You shall not edit repositories that aren't yours.")
          end
        end
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, :id => @subject.id
      end

      it { should redirect_to new_user_session_path }
    end
  end
  end

  pending "Work in progress" do
  describe 'update' do
    before do
      @subject = FactoryGirl.build(:repository)
      @subject_params = Hash[FactoryGirl.attributes_for(:repository).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the repository' do
        before do
          @ownership = FactoryGirl.build(:repository_ownership)
          @ownerships = []

          @ownerships.expects(:find_by_repository_id).with("#{@subject.id}").returns(@ownership)
          User.any_instance.expects(:repository_ownerships).at_least_once.returns(@ownerships)
        end

        context 'with valid fields' do
          before :each do
            Repository.expects(:find).with(@subject.id.to_s).returns(@subject)
            Repository.any_instance.expects(:update).with(@subject_params).returns(true)
          end

          context 'rendering the show' do
            before :each do
              Repository.expects(:exists?).returns(true)

              post :update, :id => @subject.id, :repository => @subject_params
            end

            it 'should redirect to the show view' do
              response.should redirect_to repository_path(@subject)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => @subject.id, :repository => @subject_params
            end

            it { should respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            Repository.expects(:find).with(@subject.id.to_s).returns(@subject)
            Repository.any_instance.expects(:update).with(@subject_params).returns(false)

            post :update, :id => @subject.id, :repository => @subject_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the repository' do
        before :each do
          post :update, :id => @subject.id, :repository => @subject_params
        end

        it { should redirect_to repositories_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, :id => @subject.id, :repository => @subject_params
      end

      it { should redirect_to new_user_session_path }
    end
  end
  end
end
