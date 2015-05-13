require 'rails_helper'

describe KalibroConfigurationsController, :type => :controller do

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
	    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }
	    let(:subject_params) { kalibro_configuration.to_hash }

     	before :each do
        KalibroConfiguration.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          post :create, :kalibro_configuration => subject_params
        end

        it 'should redirect to the show view' do
          expect(response).to redirect_to kalibro_configuration_path(id: kalibro_configuration.id)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post :create, :kalibro_configuration => subject_params
        end

        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
        @subject_params = @subject.to_hash

        KalibroConfiguration.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        KalibroConfiguration.any_instance.expects(:save).returns(false)

        post :create, :kalibro_configuration => @subject_params
      end

      it { is_expected.to render_template(:new) }
    end
  end

  describe 'show' do
  	let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }
  	let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    before :each do
      kalibro_configuration.expects(:metric_configurations).returns(metric_configuration)
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

      get :show, :id => kalibro_configuration.id
    end

    it { is_expected.to render_template(:show) }

    after :each do
      Rails.cache.clear
    end
  end

  describe 'destroy' do
    before do
      @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
    end

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:kalibro_configuration_ownership)
        @ownerships = []
      end

      context 'when the user owns the kalibro_configuration' do
        before :each do
          @ownership.expects(:destroy)
          @subject.expects(:destroy)

          #Those two mocks looks the same but they are necessary since params[:id] is a String and @configuration.id is an Integer :(
          @ownerships.expects(:find_by_kalibro_configuration_id).with("#{@subject.id}").returns(@ownership)
          @ownerships.expects(:find_by_kalibro_configuration_id!).with(@subject.id).returns(@ownership)

          User.any_instance.expects(:kalibro_configuration_ownerships).at_least_once.returns(@ownerships)

          KalibroConfiguration.expects(:find).with(@subject.id).returns(@subject)
          delete :destroy, :id => @subject.id
        end

        it 'should redirect to the kalibro_configurations page' do
          expect(response).to redirect_to kalibro_configurations_url
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the kalibro_configuration" do
        before :each do
          @ownerships.expects(:find_by_kalibro_configuration_id).with("#{@subject.id}").returns(nil)
          User.any_instance.expects(:kalibro_configuration_ownerships).at_least_once.returns(@ownerships)

          delete :destroy, :id => @subject.id
        end

         it { is_expected.to redirect_to(kalibro_configurations_path(id: @subject.id))  }
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
      @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
      KalibroConfiguration.expects(:all).returns([@subject])
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
    end

    context 'with an User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:kalibro_configuration_ownership)
        @ownerships = []

        User.any_instance.expects(:kalibro_configuration_ownerships).at_least_once.returns(@ownerships)

        sign_in @user
      end

      context 'when the user owns the kalibro_configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(@subject.id).returns(@subject)
          @ownerships.expects(:find_by_kalibro_configuration_id).with("#{@subject.id}").returns(@ownership)

          get :edit, :id => @subject.id
        end

        it { is_expected.to render_template(:edit) }

        it 'should assign to @kalibro_configuration the @subject' do
          expect(assigns(:kalibro_configuration)).to eq(@subject)
        end
      end

      context 'when the user does not own the kalibro_configuration' do
        before do
          @subject = FactoryGirl.build(:another_kalibro_configuration, :with_id)
          @ownerships.expects(:find_by_kalibro_configuration_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: @subject.id))  }
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
    let(:kalibro_configuration) {FactoryGirl.build(:kalibro_configuration, :with_id)}
    let(:kalibro_configuration_params) { kalibro_configuration.to_hash }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the kalibro_configuration' do
        before do
          @ownership = FactoryGirl.build(:kalibro_configuration_ownership)
          @ownerships = []

          @ownerships.expects(:find_by_kalibro_configuration_id).with("#{kalibro_configuration.id}").returns(@ownership)
          User.any_instance.expects(:kalibro_configuration_ownerships).at_least_once.returns(@ownerships)
        end

        context 'with valid fields' do
          before :each do
            KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
            KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(true)
          end

          context 'rendering the show' do
            before :each do
              post :update, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params
            end

            it 'should redirect to the show view' do
              expect(response).to redirect_to kalibro_configuration_path(id: kalibro_configuration.id)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params
            end

            it { is_expected.to respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
            KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(false)

            post :update, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the kalibro_configuration' do
        before :each do
          post :update, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params
        end

        it { is_expected.to redirect_to kalibro_configurations_path(id: kalibro_configuration.id) }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
