require 'rails_helper'

describe ProjectsHelper, :type => :helper do

  describe 'project_owner?' do
    before :each do
      @subject = FactoryGirl.build(:project_with_id)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { expect(helper.project_owner?(@subject.id)).to be_falsey }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @attributes = []
        @attributes.expects(:find_by_project_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:project_attributes).returns(@attributes)
      end

      it { expect(helper.project_owner?(@subject.id)).to be_falsey }
    end

    context 'returns true if user is the project owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @project_attributes = FactoryGirl.build(:project_attributes)
        @attributes = []
        @attributes.expects(:find_by_project_id).with(@subject.id).returns(@project_attributes)
        User.any_instance.expects(:project_attributes).returns(@attributes)
      end

      it { expect(helper.project_owner?(@subject.id)).to be_truthy }
    end
  end

  describe 'project_image_html' do
    let(:project) { FactoryGirl.build(:project) }
    let(:project_attributes) { FactoryGirl.build(:project_attributes, :with_image) }

    context 'when the project has an image' do
      before :each do
        project.expects(:attributes).twice.returns(project_attributes)
      end

      it 'is expected to return an image tag with the project attribute URL' do
        expect(helper.project_image_html(project)).to include("<img")
        expect(helper.project_image_html(project)).to include(project_attributes.image_url)
      end
    end

    context 'when the project does not have an image' do
      before :each do
        project_attributes.image_url = ""
        project.expects(:attributes).twice.returns(project_attributes)
      end

      it 'is expected to return a default image icon with a message' do
        expect(helper.project_image_html(project)).to include("<i class")
        expect(helper.project_image_html(project)).to include(I18n.t('no_image_available'))
      end
    end
  end

end
