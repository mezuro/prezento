require 'spec_helper'

describe User do
  context 'validations' do
    subject { FactoryGirl.build(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
