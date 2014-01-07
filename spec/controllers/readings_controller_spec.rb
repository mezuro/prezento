require 'spec_helper'

describe ReadingsController do
  let(:reading_group) { FactoryGirl.build(:reading_group) }

  describe 'new' do
    before :each do
      sign_in FactoryGirl.create(:user)
      get :new, reading_group_id: reading_group.id
    end

    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe 'create' do
    let(:reading) { FactoryGirl.build(:reading) }
    let(:reading_params) { Hash[FactoryGirl.attributes_for(:reading).map { |k,v| [k.to_s, v.to_s] }] }  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before do
      sign_in FactoryGirl.create(:user)
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