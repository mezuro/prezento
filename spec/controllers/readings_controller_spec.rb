require 'rails_helper'

describe ReadingsController, :type => :controller do
  let(:reading_group) { FactoryGirl.build(:reading_group, :with_id) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:reading_group_owner?).returns true
        get :new, reading_group_id: reading_group.id
      end

      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_template(:new) }
    end

    context "when the current user doesn't owns the reading group" do
      before :each do
        get :new, reading_group_id: reading_group.id
      end

      it { is_expected.to redirect_to reading_group_path reading_group.id }
    end
  end

  describe 'create' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }
    let(:reading_params) { reading.to_hash }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:reading_group_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          Reading.any_instance.expects(:save).returns(true)

          post :create, reading_group_id: reading_group.id, reading: reading_params
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          Reading.any_instance.expects(:save).returns(false)

         post :create, reading_group_id: reading_group.id, reading: reading_params
        end

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'edit' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the reading' do
        before :each do
          subject.expects(:reading_owner?).returns true
          Reading.expects(:find).with(reading.id).returns(reading)
          get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
        end

        it { is_expected.to render_template(:edit) }
      end

      context 'when the user does not own the reading' do
        before do
          get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
        end

        it { is_expected.to redirect_to reading_group_path reading_group.id }
        it { is_expected.to set_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'update' do
    let(:reading) { FactoryGirl.build(:reading_with_id, reading_group_id: reading_group.id) }
    let(:reading_params) { reading.to_hash }

    context 'when the user is logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when user owns the reading' do
        before :each do
          subject.expects(:reading_owner?).returns true
        end

        context 'with valid fields' do
          before :each do
            Reading.expects(:find).with(reading.id).returns(reading)
            Reading.any_instance.expects(:update).with(reading_params).returns(true)

            post :update, reading_group_id: reading_group.id, id: reading.id, reading: reading_params
          end

          it { is_expected.to redirect_to(reading_group_path(reading_group.id)) }
          it { is_expected.to respond_with(:redirect) }
        end

        context 'with an invalid field' do
          before :each do
            Reading.expects(:find).with(reading.id).returns(reading)
            Reading.any_instance.expects(:update).with(reading_params).returns(false)

            post :update, reading_group_id: reading_group.id, id: reading.id, reading: reading_params
          end

          it { is_expected.to render_template(:edit) }
        end
      end

      context 'when the user does not own the reading' do
        before :each do
          post :update, reading_group_id: reading_group.id, id: reading.id, reading: reading_params
        end

        it { is_expected.to redirect_to reading_group_path(reading_group.id) }
      end
    end

    context 'with no user logged in' do
      before :each do
        post :update, reading_group_id: reading_group.id, id: reading.id, reading: reading_params
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'destroy' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }

    context 'with a User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the reading group' do
        before :each do
          subject.expects(:reading_owner?).returns true
          reading.expects(:destroy)
          Reading.expects(:find).with(reading.id).returns(reading)

          delete :destroy, id: reading.id, reading_group_id: reading.reading_group_id.to_s
        end

        it { is_expected.to redirect_to(reading_group_path(reading.reading_group_id)) }
        it { is_expected.to respond_with(:redirect) }
      end

      context "when the user doesn't own the reading group" do
        before :each do
          delete :destroy, id: reading.id, reading_group_id: reading.reading_group_id.to_s
        end

        it { is_expected.to redirect_to(reading_group_path(reading.reading_group_id)) }
        it { is_expected.to respond_with(:redirect) }
      end
    end

    context 'with no User logged in' do
      before :each do
        delete :destroy, id: reading.id, reading_group_id: reading.reading_group_id.to_s
      end

      it { is_expected.to redirect_to new_user_session_path }
    end
  end

end
