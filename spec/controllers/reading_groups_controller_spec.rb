require 'spec_helper'

describe ReadingGroupsController do
  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
      get :new
    end

    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe 'create' do
    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'with valid fields' do
	    let(:reading_group) { FactoryGirl.build(:reading_group) }
	    let(:subject_params) { Hash[FactoryGirl.attributes_for(:reading_group).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

     	before :each do
        ReadingGroup.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          ReadingGroup.expects(:exists?).returns(true)

          post :create, :reading_group => subject_params
        end

        it 'should redirect to the show view' do
          response.should redirect_to reading_group_path(reading_group)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post :create, :reading_group => subject_params
        end

        it { should respond_with(:redirect) }
      end
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:reading_group)
        @subject_params = Hash[FactoryGirl.attributes_for(:reading_group).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

        ReadingGroup.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        ReadingGroup.any_instance.expects(:save).returns(false)

        post :create, :reading_group => @subject_params
      end

      it { should render_template(:new) }
    end
  end

  describe 'show' do
  	subject { FactoryGirl.build(:reading_group) }
  	let(:reading) { FactoryGirl.build(:reading) }
    before :each do
      ReadingGroup.expects(:find).with(subject.id.to_s).returns(subject)
      get :show, :id => subject.id
    end

    it { should render_template(:show) }
  end

  describe 'destroy' do
    before do
      @subject = FactoryGirl.build(:reading_group)
    end

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:reading_group_ownership)
        @ownerships = []

      end

      context 'when the user owns the reading group' do
        before :each do
          @ownership.expects(:destroy)
          @subject.expects(:destroy)

          #Those two mocks looks the same but they are necessary since params[:id] is a String and @ReadingGroup.id is an Integer :(
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(@ownership)
          @ownerships.expects(:find_by_reading_group_id).with(@subject.id).returns(@ownership)

          User.any_instance.expects(:reading_group_ownerships).at_least_once.returns(@ownerships)

          ReadingGroup.expects(:find).with(@subject.id.to_s).returns(@subject)
          delete :destroy, :id => @subject.id
        end

        it 'should redirect to the reading groups page' do
          response.should redirect_to reading_groups_url
        end

        it { should respond_with(:redirect) }
      end

      context "when the user doesn't own the reading group" do
        before :each do
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(nil)
          User.any_instance.expects(:reading_group_ownerships).at_least_once.returns(@ownerships)

          delete :destroy, :id => @subject.id
        end

         it { should redirect_to(reading_group_path)  }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, :id => @subject.id
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'index' do
    before :each do
      @subject = FactoryGirl.build(:reading_group)
      ReadingGroup.expects(:all).returns([@subject])
      get :index
    end

    it { should render_template(:index) }
  end

  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:reading_group)
    end

    context 'with an User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:reading_group_ownership)
        @ownerships = []

        User.any_instance.expects(:reading_group_ownerships).at_least_once.returns(@ownerships)

        sign_in @user
      end

      context 'when the user owns the reading group' do
        before :each do
          ReadingGroup.expects(:find).with(@subject.id.to_s).returns(@subject)
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(@ownership)

          get :edit, :id => @subject.id
        end

        it { should render_template(:edit) }

        it 'should assign to @reading group the @subject' do
          assigns(:reading_group).should eq(@subject)
        end
      end

      context 'when the user does not own the reading group' do
        before do
          @subject = FactoryGirl.build(:another_reading_group)
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { should redirect_to(reading_group_path)  }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, :id => @subject.id
      end

      it { should redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    before do
      @subject = FactoryGirl.build(:reading_group)
      @subject_params = Hash[FactoryGirl.attributes_for(:reading_group).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the reading group' do
        before do
          @ownership = FactoryGirl.build(:reading_group_ownership)
          @ownerships = []

          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(@ownership)
          User.any_instance.expects(:reading_group_ownerships).at_least_once.returns(@ownerships)
        end

        context 'with valid fields' do
          before :each do
            ReadingGroup.expects(:find).with(@subject.id.to_s).returns(@subject)
            ReadingGroup.any_instance.expects(:update).with(@subject_params).returns(true)
          end

          context 'rendering the show' do
            before :each do
              ReadingGroup.expects(:exists?).returns(true)

              post :update, :id => @subject.id, :reading_group => @subject_params
            end

            it 'should redirect to the show view' do
              response.should redirect_to reading_group_path(@subject)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => @subject.id, :reading_group => @subject_params
            end

            it { should respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            ReadingGroup.expects(:find).with(@subject.id.to_s).returns(@subject)
            ReadingGroup.any_instance.expects(:update).with(@subject_params).returns(false)

            post :update, :id => @subject.id, :reading_group => @subject_params
          end

          it { should render_template(:edit) }
        end
      end

      context 'when the user does not own the reading group' do
        before :each do
          post :update, :id => @subject.id, :reading_group => @subject_params
        end

        it { should redirect_to reading_group_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, :id => @subject.id, :reading_group => @subject_params
      end

      it { should redirect_to new_user_session_path }
    end
  end
end
