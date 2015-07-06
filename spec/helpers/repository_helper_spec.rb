require 'rails_helper'

describe RepositoryHelper, :type => :helper do
  describe 'repository_owner?' do
    subject { FactoryGirl.build(:repository) }

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { expect(helper.repository_owner?(subject.id)).to be_falsey }
    end

    context 'returns false if is not the owner' do
      let!(:attributes) { [] }

      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        attributes.expects(:find_by_repository_id).with(subject.id).returns(nil)

        User.any_instance.expects(:repository_attributes).returns(attributes)
      end

      it { expect(helper.repository_owner?(subject.id)).to be_falsey }
    end

    context 'returns true if user is the repository owner' do
      let!(:repository_attributes) { FactoryGirl.build(:repository_attributes) }
      let!(:attributes) { [] }

      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        attributes.expects(:find_by_repository_id).with(subject.id).returns(repository_attributes)
        User.any_instance.expects(:repository_attributes).returns(attributes)
      end

      it { expect(helper.repository_owner?(subject.id)).to be_truthy }
    end
  end

  describe 'periodicity_options' do
    it 'should return an array with some sample periods' do
      expect(helper.periodicity_options).to eq [["Not Periodically", 0], ["1 day", 1], ["2 days", 2], ["Weekly", 7], ["Biweekly", 15], ["Monthly", 30]]
    end
  end

  describe 'license_options' do
    it 'should return an array with some sample licenses names' do
      expect(helper.license_options).to eq YAML.load_file("config/licenses.yml").split("; ")
    end
  end

  describe 'periodicity_option' do
    it 'should return the periodicity option associated to the given number' do
      expect(helper.periodicity_option(1)).to eq "1 day"
    end
  end

  describe 'calendar' do
    it 'should return an array with the number of days' do
      days = (1..31).to_a.map {|day| [day, day]}
      expect(helper.day_options).to eq days
    end

    it 'should return an array with the number of months' do
      months = (1..12).to_a.map {|month| [month, month]}
      expect(helper.month_options).to eq months
    end

    it 'should return a range of years' do
      years = (2013..2020).to_a.map {|year| [year, year]}
      expect(helper.year_options).to eq years
    end
  end

end
