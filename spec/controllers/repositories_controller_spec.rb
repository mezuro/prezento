require 'rails_helper'

describe RepositoriesController, :type => :controller do
  let(:project) { FactoryGirl.build(:project_with_id) }

  describe 'new' do
    context 'with a User logged in' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:kalibro_configurations) { [FactoryGirl.build(:kalibro_configuration)] }
      before :each do
        sign_in user
      end

      context 'when the current user owns the project' do
        before :each do
          KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
          Repository.expects(:repository_types).returns([])
          subject.expects(:project_owner?).returns true

          get :new, project_id: project.id.to_s
        end

        it { is_expected.to respond_with(:success) }
        it { is_expected.to render_template(:new) }
      end

      context "when the current user doesn't own the project" do
        before :each do
          get :new, project_id: project.id.to_s
        end

        it { is_expected.to redirect_to(projects_url) }
        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :new, project_id: project.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'create' do
    let (:repository) { FactoryGirl.build(:repository, project_id: project.id) }
    let(:repository_params) { FactoryGirl.build(:repository).to_hash }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the project' do
      before :each do
        subject.expects(:project_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          Repository.any_instance.expects(:save).returns(true)

          post :create, project_id: project.id, repository: repository_params
        end

        it { is_expected.to redirect_to(project_repository_process_path(project_id: repository.project_id, id: repository.id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context 'with an invalid field' do
        before :each do
          Repository.any_instance.expects(:save).returns(false)
          Repository.expects(:repository_types).returns([])

          post :create, project_id: project.id.to_s, repository: repository_params
        end

        it { is_expected.to render_template(:new) }
      end
    end

    context "when the current user doesn't own the project " do
      before :each do
        post :create, project_id: project.id, repository: repository_params
      end

      it { is_expected.to redirect_to(projects_url) }
      it { is_expected.to respond_with(:redirect) }
    end
  end

  describe 'show' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'without a specific module_result' do
      before :each do
        KalibroConfiguration.expects(:find).with(repository.id).returns(FactoryGirl.build(:kalibro_configuration, :with_id))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s, project_id: project.id.to_s
      end

      it { is_expected.to render_template(:show) }
    end

    context 'for an specific module_result' do

      before :each do
        KalibroConfiguration.expects(:find).with(repository.id).returns(FactoryGirl.build(:kalibro_configuration, :with_id))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s, project_id: project.id.to_s
      end

      it { is_expected.to render_template(:show) }
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
          subject.expects(:repository_owner?).returns true
          repository.expects(:destroy)
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

          delete :destroy, id: repository.id, project_id: project.id.to_s
        end

        it { is_expected.to redirect_to(project_path(repository.project_id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the project" do
        before :each do
          delete :destroy, id: repository.id, project_id: project.id.to_s
        end

         it { is_expected.to redirect_to(projects_url) }
         it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: repository.id, project_id: project.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'edit' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'with an User logged in' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:kalibro_configurations) { [FactoryGirl.build(:kalibro_configuration)] }
      before do
        sign_in user
      end

      context 'when the user owns the repository' do
        before :each do
          KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
          subject.expects(:repository_owner?).returns true
          Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
          Repository.expects(:repository_types).returns(["SUBVERSION"])
          get :edit, id: repository.id, project_id: project.id.to_s
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the repository' do
        before do
          get :edit, id: repository.id, project_id: project.id.to_s
        end

        it { is_expected.to redirect_to(projects_url) }
        it { is_expected.to respond_with(:redirect) }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: repository.id, project_id: project.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
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
          subject.expects(:repository_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(true)

            post :update, project_id: project.id.to_s, id: repository.id, repository: repository_params
          end

          it { is_expected.to redirect_to(project_repository_path(repository.project_id, repository.id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(false)
            Repository.expects(:repository_types).returns([])

            post :update, project_id: project.id.to_s, id: repository.id, repository: repository_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the repository' do
        before :each do
          post :update, project_id: project.id.to_s, id: repository.id, repository: repository_params
        end

        it { is_expected.to redirect_to projects_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, project_id: project.id.to_s, id: repository.id, repository: repository_params
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'state' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'with a READY state' do
      let(:ready_processing) { FactoryGirl.build(:processing) }

      before :each do
        repository.expects(:last_processing).returns(ready_processing)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {project_id: project.id.to_s, id: repository.id, last_state: 'ANALYZING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:load_ready_processing) }
    end

    context 'with another state then READY' do
      let(:processing) { FactoryGirl.build(:processing, state: 'ANALYZING') }

       before :each do
        repository.expects(:last_processing).returns(processing)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {project_id: project.id.to_s, id: repository.id, last_state: 'LOADING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:reload_processing) }
    end

    context 'when it was already READY' do
      before :each do
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {project_id: project.id.to_s, id: repository.id, last_state: 'READY'}
      end

      it { is_expected.to respond_with(:ok) }
      it { is_expected.not_to render_with_layout }
    end


    context 'with a ERROR state' do
      let(:errored_processing) { FactoryGirl.build(:errored_processing) }

      before :each do
        repository.expects(:last_processing).returns(errored_processing)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {project_id: project.id.to_s, id: repository.id, last_state: 'ANALYZING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:load_error) }
    end
  end

  describe 'state_with_date' do
    let(:processing) { FactoryGirl.build(:processing) }
    let(:repository) { FactoryGirl.build(:repository) }

    before :each do
      Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
      Processing.expects(:processing_with_date_of).with(repository.id, "2013-11-11").returns(processing)

      xhr :get, :state_with_date, {project_id: project.id.to_s, id: repository.id, day: '11', month: '11', year: '2013'}
    end

    it { is_expected.to respond_with(:ok) }
    it { is_expected.not_to render_with_layout }
  end

  describe 'process_repository' do
      let(:repository) { FactoryGirl.build(:repository) }
      before :each do
        sign_in FactoryGirl.create(:user)
        subject.expects(:repository_owner?).returns true
        repository.expects(:process)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
        KalibroConfiguration.expects(:find).with(repository.id).returns(FactoryGirl.build(:kalibro_configuration, :with_id))
        get :process_repository, project_id: project.id.to_s, id: repository.id
      end
      it { is_expected.to redirect_to(project_repository_path(repository.project_id, repository.id)) }
  end
end
