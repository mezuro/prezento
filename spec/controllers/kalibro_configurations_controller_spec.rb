require 'rails_helper'

describe KalibroConfigurationsController, :type => :controller do
  
  def post_method(method)
    unless method == :create
      post method, :id => kalibro_configuration.id, :kalibro_configuration => kalibro_configuration_params, :attributes => attributes
    else
      post method, :kalibro_configuration => kalibro_configuration_params, :attributes => attributes
    end
  end

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
	    let(:kalibro_configuration_params) { kalibro_configuration.to_hash }
      let(:attributes) { {public: "1"} } 

     	before :each do
        KalibroConfiguration.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          post_method :create
        end

        it 'should redirect to the show view' do
          expect(response).to redirect_to kalibro_configuration_path(id: kalibro_configuration.id)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post_method :create
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
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

    context 'with an User logged in' do
      let(:kalibro_configuration_attribute) { FactoryGirl.build(:kalibro_configuration_attributes) }
      let(:kalibro_configuration_attributes) { mock('kalibro_configuration_attributes') }

      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the kalibro_configuration' do
        before :each do
          kalibro_configuration_attribute.expects(:destroy)
          kalibro_configuration.expects(:destroy)

          #Those two mocks looks the same but they are necessary since params[:id] is a String and @configuration.id is an Integer :(
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id).with("#{kalibro_configuration.id}").returns(kalibro_configuration_attribute)
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id!).with(kalibro_configuration.id).returns(kalibro_configuration_attribute)

          User.any_instance.expects(:kalibro_configuration_attributes).at_least_once.returns(kalibro_configuration_attributes)

          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          delete :destroy, :id => kalibro_configuration.id
        end

        it 'should redirect to the kalibro_configurations page' do
          expect(response).to redirect_to kalibro_configurations_url
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the kalibro_configuration" do
        before :each do
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id).with("#{kalibro_configuration.id}").returns(nil)
          User.any_instance.expects(:kalibro_configuration_attributes).at_least_once.returns(kalibro_configuration_attributes)

          delete :destroy, :id => kalibro_configuration.id
        end

         it { is_expected.to redirect_to(kalibro_configurations_path(id: kalibro_configuration.id))  }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, :id => kalibro_configuration.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'index' do
    let!(:kalibro_configuration_attribute) { FactoryGirl.build(:kalibro_configuration_attributes) }
    before :each do
      @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
      KalibroConfigurationAttributes.expects(:where).with(public: true).returns([kalibro_configuration_attribute])
      KalibroConfiguration.expects(:find).with(kalibro_configuration_attribute.kalibro_configuration_id).returns(@subject)
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'edit' do
    let!(:user) { FactoryGirl.create(:user) }
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }
    let(:kalibro_configuration_attribute) { FactoryGirl.build(:kalibro_configuration_attributes) }
    let(:kalibro_configuration_attributes) { mock('kalibro_configuration_attributes') }

    context 'with an User logged in' do
      before do
        User.any_instance.expects(:kalibro_configuration_attributes).at_least_once.returns(kalibro_configuration_attributes)

        sign_in user
      end

      context 'when the user owns the kalibro_configuration' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id).with("#{kalibro_configuration.id}").returns(kalibro_configuration_attribute)

          get :edit, :id => kalibro_configuration.id
        end

        it { is_expected.to render_template(:edit) }

        it 'should assign to @kalibro_configuration the kalibro_configuration' do
          expect(assigns(:kalibro_configuration)).to eq(kalibro_configuration)
        end
      end

      context 'when the user does not own the kalibro_configuration' do
        let!(:another_kalibro_configuration) { FactoryGirl.build(:another_kalibro_configuration, :with_id) }

        before :each do
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id).with("#{another_kalibro_configuration.id}").returns(nil)

          get :edit, :id => another_kalibro_configuration.id
        end

        it { is_expected.to redirect_to(kalibro_configurations_path(id: another_kalibro_configuration.id))  }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, :id => kalibro_configuration.id
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let!(:kalibro_configuration) {FactoryGirl.build(:kalibro_configuration, :with_id)}
    let!(:kalibro_configuration_params) { kalibro_configuration.to_hash }
    let!(:attributes) { {public: "1"} }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the kalibro_configuration' do
        let(:kalibro_configuration_attribute) { FactoryGirl.build(:kalibro_configuration_attributes) }
        let(:kalibro_configuration_attributes) { mock('kalibro_configuration_attributes') }

        before :each do
          kalibro_configuration_attributes.expects(:find_by_kalibro_configuration_id).with("#{kalibro_configuration.id}").returns(kalibro_configuration_attribute)
          User.any_instance.expects(:kalibro_configuration_attributes).at_least_once.returns(kalibro_configuration_attributes)
        end

        context 'with valid fields' do
          before :each do
            KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
            KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(true)
            kalibro_configuration.expects(:attributes).returns(kalibro_configuration_attribute)
          end

          context 'rendering the show' do
            before :each do
              post_method :update
            end

            it 'should redirect to the show view' do
              expect(response).to redirect_to kalibro_configuration_path(id: kalibro_configuration.id)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post_method :update
            end

            it { is_expected.to respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
            KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(false)

            post_method :update
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the kalibro_configuration' do
        before :each do
          post_method :update
        end

        it { is_expected.to redirect_to kalibro_configurations_path(id: kalibro_configuration.id) }
      end
    end

    context 'with no user logged in' do
      before :each do
        post_method :update
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
