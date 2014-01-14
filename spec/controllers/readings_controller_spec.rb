require 'spec_helper'

describe ReadingsController do
  let(:reading_group) { FactoryGirl.build(:reading_group) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:reading_owner?).returns true
        get :new, reading_group_id: reading_group.id
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    context "when the current user doesn't owns the reading group" do
      before :each do
        get :new, reading_group_id: reading_group.id
      end

      it { should redirect_to(reading_group_url(reading_group.id)) }
      it { should respond_with(:redirect) }
    end
  end

  describe 'create' do
    let(:reading) { FactoryGirl.build(:reading) }
    let(:reading_params) { Hash[FactoryGirl.attributes_for(:reading).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the reading group' do
      before :each do
        subject.expects(:reading_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          Reading.any_instance.expects(:save).returns(true)

          post :create, reading_group_id: reading_group.id, reading: reading_params
        end

        it { should respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          Reading.any_instance.expects(:save).returns(false)

         post :create, reading_group_id: reading_group.id, reading: reading_params
        end

        it { should render_template(:new) }
      end
    end
  end

  describe 'edit' do
    let(:reading) { FactoryGirl.build(:reading) }

    context 'with an User logged in' do
      before do
        sign_in FactoryGirl.create(:user)
      end

      context 'when the user owns the reading' do
        before :each do
          subject.expects(:reading_owner?).returns true
          Reading.expects(:find).at_least_once.with(reading.id).returns(reading)
          get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
        end

        it { should render_template(:edit) }
      end

      context 'when the user does not own the reading' do
        before do
          Reading.expects(:find).at_least_once.with(reading.id).returns(reading)

          get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
        end

        it { should redirect_to(reading_group_url(reading_group.id)) }
        it { should respond_with(:redirect) }
        it { should set_the_flash[:notice].to("You're not allowed to do this operation") }
      end
    end

    context 'with no user logged in' do
      before :each do
        get :edit, id: reading.id, reading_group_id: reading_group.id.to_s
      end

      it { should redirect_to new_user_session_path }
    end
  end
end