require 'rails_helper'

RSpec.describe ProjectImage, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { should belong_to(:project) }
  end

  describe 'methods' do

    it 'should validate url blank' do
      @project_no_image = FactoryGirl.create(:project_no_image)
      expect(@project_no_image.image_url).to eq("no-image-available.png")
    end

    it "Can be assigns" do
      expect(ProjectImage.new).to be_an_instance_of(ProjectImage)
    end

    it 'should validate url field' do
      @project_no_image = FactoryGirl.create(:project_no_image)
      expect(@project_no_image.check_no_image).to eq("")
    end
  end
end
