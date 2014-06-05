require 'rails_helper'

describe RepositoryHelper, :type => :helper do

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

    it 'should return Undefined when there is no periodicity value' do
      expect(helper.periodicity_option(nil)).to eq "Undefined"
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
