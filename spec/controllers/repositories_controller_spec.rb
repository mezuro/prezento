require 'rails_helper'

describe RepositoriesController, :type => :controller do
  describe 'index' do
    let!(:repository) { FactoryGirl.build(:repository) }

    before :each do
      Repository.expects(:public_or_owned_by_user).returns([repository])
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'new' do
    context 'with a User logged in' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:kalibro_configurations) { [FactoryGirl.build(:kalibro_configuration)] }
      before :each do
        sign_in user
      end

      context 'when a project_id is provided' do
        let(:project) { FactoryGirl.build(:project_with_id) }

        context 'and the current user owns the project' do
          before :each do
            KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
            Repository.expects(:repository_types).returns([])
            subject.expects(:project_owner?).returns true

            get :new, project_id: project.id.to_json
          end

          it { is_expected.to respond_with(:success) }
          it { is_expected.to render_template(:new) }
        end

        context "and the current user doesn't own the project" do
          before :each do
            get :new, project_id: project.id.to_s
          end

          it { is_expected.to redirect_to(projects_path) }
        end
      end

      context 'when no project_id is provided' do
        before :each do
          KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
          Repository.expects(:repository_types).returns([])

          get :new
        end

        it { is_expected.to respond_with(:success) }
        it { is_expected.to render_template(:new) }
      end
    end

    context 'with no user logged in' do
      let(:project) { FactoryGirl.build(:project_with_id) }

      before :each do
        get :new, project_id: project.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'create' do
    let!(:kalibro_configurations) { [FactoryGirl.build(:kalibro_configuration)] }
    let!(:user) { FactoryGirl.create(:user) }
    let(:repository_params) { FactoryGirl.build(:repository).to_hash }

    before do
      sign_in user
    end

    context 'when a project_id is provided' do
      let(:project) { FactoryGirl.build(:project_with_id) }
      let(:repository) { FactoryGirl.build(:repository, project_id: project.id) }

      context 'and the current user owns the project' do
        before :each do
          subject.expects(:project_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            Repository.any_instance.expects(:save).returns(true)

            post :create, project_id: project.id, repository: repository_params
          end

          it { is_expected.to redirect_to(repository_process_path(id: repository.id)) }
          it { is_expected.to respond_with(:redirect) }
          it "is expected to set the project_id" do
            expect(assigns(:repository).project_id).to be > 0
          end
        end

        context 'with an invalid field' do
          before :each do
            KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
            Repository.any_instance.expects(:save).returns(false)
            Repository.expects(:repository_types).returns([])

            post :create, project_id: project.id.to_s, repository: repository_params
          end

          it { is_expected.to render_template(:new) }
        end
      end

      context "and the current user doesn't own the project " do
        before :each do
          post :create, project_id: project.id, repository: repository_params
        end

        it { is_expected.to redirect_to projects_path }
      end
    end

    context 'when no project_id is provided' do
      let(:repository) { FactoryGirl.build(:repository) }

      context 'with valid fields' do
        before :each do
          Repository.any_instance.expects(:save).returns(true)

          post :create, repository: repository_params
        end

        it { is_expected.to redirect_to(repository_process_path(id: repository.id)) }
        it { is_expected.to respond_with(:redirect) }
        it "is expected to not set the project_id" do
          expect(assigns(:repository).project_id).to be_nil
        end
      end

      context 'with an invalid field' do
        before :each do
          KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
          Repository.any_instance.expects(:save).returns(false)
          Repository.expects(:repository_types).returns([])

          post :create.to_s, repository: repository_params
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'show' do
    let(:repository) { FactoryGirl.build(:repository) }

    context 'without a specific module_result' do
      before :each do
        KalibroConfiguration.expects(:find).with(repository.id).returns(FactoryGirl.build(:kalibro_configuration, :with_id))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s
      end

      it { is_expected.to render_template(:show) }
    end

    context 'for an specific module_result' do
      before :each do
        KalibroConfiguration.expects(:find).with(repository.id).returns(FactoryGirl.build(:kalibro_configuration, :with_id))
        Repository.expects(:find).with(repository.id).returns(repository)

        get :show, id: repository.id.to_s
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

          delete :destroy, id: repository.id
        end

        it { is_expected.to redirect_to(projects_path) }
        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the project" do
        before :each do
          delete :destroy, id: repository.id
        end

        it { is_expected.to redirect_to projects_path }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: repository.id
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
          get :edit, id: repository.id
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the repository' do
        before do
          get :edit, id: repository.id
        end

        it { is_expected.to redirect_to projects_path }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: repository.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:kalibro_configurations) { [FactoryGirl.build(:kalibro_configuration)] }
    let(:repository) { FactoryGirl.build(:repository) }
    let(:repository_params) { Hash[FactoryGirl.attributes_for(:repository).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

    context 'when the user is logged in' do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      context 'when user owns the repository' do
        before :each do
          subject.expects(:repository_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(true)

            post :update, id: repository.id, repository: repository_params
          end

          it { is_expected.to redirect_to(repository_path(repository.id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            KalibroConfiguration.expects(:public_or_owned_by_user).with(user).returns(kalibro_configurations)
            Repository.expects(:find).at_least_once.with(repository.id).returns(repository)
            Repository.any_instance.expects(:update).with(repository_params).returns(false)
            Repository.expects(:repository_types).returns([])

            post :update, id: repository.id, repository: repository_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the repository' do
        before :each do
          post :update, id: repository.id, repository: repository_params
        end

        it { is_expected.to redirect_to projects_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, id: repository.id, repository: repository_params
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

        xhr :get, :state, {id: repository.id, last_state: 'ANALYZING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:load_ready_processing) }
    end

    context 'with another state then READY' do
      let(:processing) { FactoryGirl.build(:processing, state: 'ANALYZING') }

      before :each do
        repository.expects(:last_processing).returns(processing)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {id: repository.id, last_state: 'LOADING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:reload_processing) }
    end

    context 'when it was already READY' do
      before :each do
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {id: repository.id, last_state: 'READY'}
      end

      it { is_expected.to respond_with(:ok) }
      it { is_expected.not_to render_with_layout }
    end


    context 'with a ERROR state' do
      let(:errored_processing) { FactoryGirl.build(:errored_processing) }

      before :each do
        repository.expects(:last_processing).returns(errored_processing)
        Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

        xhr :get, :state, {id: repository.id, last_state: 'ANALYZING'}
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:load_error) }
    end
  end

  describe 'state_with_date' do
    let(:processing) { FactoryGirl.build(:processing) }
    let(:repository) { FactoryGirl.build(:repository) }

    before :each do
      repository.expects(:processing_with_date).with("2013-11-11").returns(processing)
      Repository.expects(:find).at_least_once.with(repository.id).returns(repository)

      xhr :get, :state_with_date, {id: repository.id, day: '11', month: '11', year: '2013'}
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
      get :process_repository, id: repository.id
    end
    it { is_expected.to redirect_to(repository_path(repository.id)) }
  end

  describe 'branches' do
    let(:url) { "dummy-url" }
    let(:scm_type) { "GIT" }

    context 'valid parameters' do
      let!(:branches) { ['branch1', 'branch2'] }

      before :each do
        sign_in FactoryGirl.create(:user)
        Repository.expects(:branches).with(url, scm_type).returns(branches: branches)
        get :branches, url: url, scm_type: scm_type, format: :json
      end

      it 'is expected to return a list of branches' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({branches: branches}.to_json))
      end

      it { is_expected.to respond_with(:success) }
    end

    context 'invalid parameters' do
      before :each do
        sign_in FactoryGirl.create(:user)
        Repository.expects(:branches).with(url, scm_type).returns(errors: ['Error'])
        get :branches, url: url, scm_type: scm_type, format: :json
      end

      it 'is expected to return an empty list' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['Error']}.to_json))
      end

      it { is_expected.to respond_with(:success) }
    end
  end

  describe 'branches_params' do
    let!(:url) { 'dummy-url' }
    let!(:scm_type) { 'GIT' }
    let(:parameters) { ActionController::Parameters.new(scm_type: scm_type, url: url) }

    context 'valid parameters' do
      it 'should return a hash with the permitted parameters' do
        subject.params = parameters
        expect(subject.params.permitted?).to be_falsey
        result = subject.send(:branches_params)
        expect(result).to eq(parameters)
        expect(result.permitted?).to be_truthy
      end
    end

    context 'invalid parameters' do
      let(:invalid_parameters) { ActionController::Parameters.new(scm_type: scm_type, url: url, something_evil: 'fizzbuzz') }

      it 'should return a valid parameters hash' do
        subject.params = invalid_parameters
        expect(subject.params.permitted?).to be_falsey
        result = subject.send(:branches_params)
        expect(result).to eq(parameters)
        expect(result.permitted?).to be_truthy
      end
    end
  end

  describe 'notify_push' do
    let(:repository) { FactoryGirl.build(:kalibro_client_gitlab_repository) }
    let(:webhook_request) { FactoryGirl.build(:gitlab_webhook_request) }

    def post_push
      @request.headers.merge!(webhook_request.headers)
      post :notify_push, {id: repository.id, format: :json}.merge(webhook_request.params)
    end

    context 'with a valid repository' do
      before :each do
        Repository.expects(:find).with(repository.id).returns(repository)
      end

      context 'without a valid address' do
        before :each do
          Webhooks::Base.any_instance.expects(:valid_address?).returns(false)
          post_push
        end

        it { is_expected.to respond_with(:forbidden) }
      end

      context 'with a valid address' do
        before :each do
          Webhooks::Base.any_instance.expects(:valid_address?).returns(true)
        end

        context 'without a matching branch' do
          before :each do
            Webhooks::Base.any_instance.expects(:valid_branch?).returns(false)
            repository.expects(:cancel_processing_of_repository).never
            repository.expects(:process).never
            post_push
          end

          it { is_expected.to respond_with(:ok) }
        end

        context 'with a matching branch' do
          before :each do
            Webhooks::Base.any_instance.expects(:valid_branch?).returns(true)
          end

          context 'when the repository is being processed' do
            before do
              repository.expects(:last_processing_state).returns('INTERPRETING')
              repository.expects(:cancel_processing_of_repository).once
              repository.expects(:process).once
              post_push
            end

            it { is_expected.to respond_with(:ok) }
          end

          context "when the repository's processing resulted in an error" do
            before do
              repository.expects(:last_processing_state).returns('ERROR')
              repository.expects(:process).once
              post_push
            end

            it { is_expected.to respond_with(:ok) }
          end

          context 'when the repository is not being processed' do
            before do
              repository.expects(:last_processing_state).returns('READY')
              repository.expects(:process).once
              post_push
            end

            it { is_expected.to respond_with(:ok) }
          end
        end
      end
    end

    context 'with an invalid repository' do
      before :each do
        Repository.expects(:find).with(repository.id).raises(Likeno::Errors::RecordNotFound)
        post_push
      end

      it { is_expected.to respond_with(:not_found) }
    end

    context 'with an invalid request' do
      before :each do
        Repository.expects(:find).with(repository.id).returns(repository)
        Webhooks::GitLab.any_instance.expects(:valid_request?).returns(false)
        post_push
      end

      it { is_expected.to respond_with(:unprocessable_entity) }
    end
  end
end
