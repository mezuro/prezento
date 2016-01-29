require 'rails_helper'

describe ReadingGroupsController, :type => :controller do
  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
      get :new
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe 'create' do
    let(:attributes) { {public: "1"} }
    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'with valid fields' do
      let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
      let(:subject_params) { reading_group.to_hash }

      before :each do
        ReadingGroup.any_instance.expects(:save).returns(true)
      end

      context 'rendering the show' do
        before :each do
          post :create, :reading_group => subject_params, :attributes => attributes

        end

        it 'should redirect to the show view' do
          expect(response).to redirect_to reading_group_path(reading_group.id)
        end
      end

      context 'without rendering the show view' do
        before :each do
          post :create, :reading_group => subject_params, :attributes => attributes

        end

        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with an invalid field' do
      before :each do
        @subject = FactoryGirl.build(:reading_group, :with_id)
        @subject_params = @subject.to_hash

        ReadingGroup.expects(:new).at_least_once.with(@subject_params).returns(@subject)
        ReadingGroup.any_instance.expects(:save).returns(false)

        post :create, :reading_group => @subject_params, :attributes => attributes

      end

      it { is_expected.to render_template(:new) }
    end
  end

  describe 'show' do
    let!(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }
    let(:reading) { FactoryGirl.build(:reading_with_id) }
    before :each do
      ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
      get :show, :id => reading_group.id
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'destroy' do
    before do
      @subject = FactoryGirl.build(:reading_group, :with_id)
    end

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:reading_group_attributes)
        @ownerships = []
      end

      context 'when the user owns the reading group' do
        before :each do
          @subject.expects(:destroy)
          subject.expects(:reading_group_owner?)

          ReadingGroup.expects(:find).with(@subject.id).returns(@subject)
          delete :destroy, :id => @subject.id
        end

        it { is_expected.to redirect_to reading_groups_path }
      end

      context "when the user doesn't own the reading group" do
        before :each do
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(nil)
          User.any_instance.expects(:reading_group_attributes).at_least_once.returns(@ownerships)

          delete :destroy, :id => @subject.id
        end

        it { is_expected.to redirect_to(reading_group_path)  }
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
    let!(:reading_group_attribute) { FactoryGirl.build(:reading_group_attributes) }
    before :each do
      @subject = FactoryGirl.build(:reading_group, :with_id)
      ReadingGroupAttributes.expects(:where).with(public: true).returns([reading_group_attribute])
      ReadingGroup.expects(:find).with(reading_group_attribute.reading_group_id).returns([@subject])
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe 'edit' do
    before do
      @subject = FactoryGirl.build(:reading_group, :with_id)
    end

    context 'with a User logged in' do
      before do
        @user = FactoryGirl.create(:user)
        @ownership = FactoryGirl.build(:reading_group_attributes)
        @ownerships = []

        User.any_instance.expects(:reading_group_attributes).at_least_once.returns(@ownerships)

        sign_in @user
      end

      context 'when the user owns the reading group' do
        before :each do
          ReadingGroup.expects(:find).with(@subject.id).returns(@subject)
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(@ownership)

          get :edit, :id => @subject.id
        end

        it { is_expected.to render_template(:edit) }

        it 'should assign to @reading group the @subject' do
          expect(assigns(:reading_group)).to eq(@subject)
        end
      end

      context 'when the user does not own the reading group' do
        before do
          @subject = FactoryGirl.build(:another_reading_group, :with_id)
          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(nil)

          get :edit, :id => @subject.id
        end

        it { is_expected.to redirect_to(reading_group_path)  }
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
      @subject = FactoryGirl.build(:reading_group, :with_id)
      @subject_params = @subject.to_hash
      @ownership = FactoryGirl.build(:reading_group_attributes, reading_group_id: @subject.id)
    end

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the reading group' do
        before do
          @ownerships = []

          @ownerships.expects(:find_by_reading_group_id).with("#{@subject.id}").returns(@ownership)
          User.any_instance.expects(:reading_group_attributes).at_least_once.returns(@ownerships)
        end

        context 'with valid fields' do
          before :each do
            ReadingGroup.expects(:find).with(@subject.id).returns(@subject)
            ReadingGroup.any_instance.expects(:update).with(@subject_params).returns(true)
          end

          context 'rendering the show' do
            before :each do
              post :update, :id => @subject.id, :reading_group => @subject_params, :attributes => {public: @ownership.public}
            end

            it 'should redirect to the show view' do
              expect(response).to redirect_to reading_group_path(@subject.id)
            end
          end

          context 'without rendering the show view' do
            before :each do
              post :update, :id => @subject.id, :reading_group => @subject_params, :attributes => {public: @ownership.public}

            end

            it { is_expected.to respond_with(:redirect) }
          end
        end

        context 'with an invalid field' do
          before :each do
            ReadingGroup.expects(:find).with(@subject.id).returns(@subject)
            ReadingGroup.any_instance.expects(:update).with(@subject_params).returns(false)

            post :update, :id => @subject.id, :reading_group => @subject_params, :attributes => {public: @ownership.public}

          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the reading group' do
        before :each do
          post :update, :id => @subject.id, :reading_group => @subject_params, :attributes => {public: @ownership.public}

        end

        it { is_expected.to redirect_to reading_group_path }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, :id => @subject.id, :reading_group => @subject_params, :attributes => {public: @ownership.public}

      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
