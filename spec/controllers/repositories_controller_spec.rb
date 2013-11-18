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
          Repository.expects(:repository_types).returns([])

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
    let(:repository) { FactoryGirl.build(:repository) }

    context 'without a specific module_result' do
      before :each do
        processing = FactoryGirl.build(:processing)

        repository.expects(:last_processing).returns(processing)
        KalibroEntities::Entities::Configuration.expects(:find).with(repository.id).returns(FactoryGirl.build(:configuration))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s, project_id: project.id.to_s
      end

      it { should render_template(:show) }
    end

    context 'for an specific module_result' do

      before :each do
        processing = FactoryGirl.build(:processing)

        repository.expects(:last_processing).returns(processing)
        KalibroEntities::Entities::Configuration.expects(:find).with(repository.id).returns(FactoryGirl.build(:configuration))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s, project_id: project.id.to_s
      end

      it { should render_template(:show) }
    end
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

          delete :destroy, id: repository.id, project_id: project.id.to_s
        end

         it { should redirect_to(projects_url) }
         it { should respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: repository.id, project_id: project.id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'edit' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the repository' do
        before :each do
          subject.expects(:check_repository_ownership).returns true
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
          Repository.expects(:repository_types).returns(["SUBVERSION"])
          get :edit, id: repository.id, project_id: project.id.to_s
        end

        it { should render_template(:edit) }
      end

      context 'when the user does not own the repository' do
        before do
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

          get :edit, id: repository.id, project_id: project.id.to_s
        end

        it { should redirect_to(projects_url) }
        it { should respond_with(:redirect) }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: repository.id, project_id: project.id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:repository) { FactoryGirl.build(:repository) }
    let(:repository_params) { Hash[FactoryGirl.attributes_for(:repository).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the repository' do
        before :each do
          subject.expects(:check_repository_ownership).returns true
        end

        context 'with valid fields' do
          before :each do
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(true)

            post :update, project_id: project.id.to_s, :id => repository.id, :repository => repository_params
          end

          it { should redirect_to(project_repository_path(repository.project_id, repository.id)) }
          it { should respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(false)
            Repository.expects(:repository_types).returns([])

            post :update, project_id: project.id.to_s, :id => repository.id, :repository => repository_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the repository' do
        before :each do
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

          post :update, project_id: project.id.to_s, :id => repository.id, :repository => repository_params
        end

        it { should redirect_to projects_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, project_id: project.id.to_s, :id => repository.id, :repository => repository_params
      end

      it { should redirect_to new_user_session_path }
    end
  end
end
