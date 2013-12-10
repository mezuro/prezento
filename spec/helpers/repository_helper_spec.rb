require 'spec_helper'

describe RepositoryHelper do

  describe 'periodicity_options' do
    it 'should return an array with some sample periods' do
      helper.periodicity_options.should eq [["Not Periodically", 0], ["1 day", 1], ["2 days", 2], ["Weekly", 7], ["Biweekly", 15], ["Monthly", 30]]
    end
  end

  describe 'license_options' do
    it 'should return an array with some sample licenses names' do
      helper.license_options.should eq YAML.load_file("config/licenses.yml").split("; ")
    end
  end

  describe 'periodicity_option' do
    it 'should return the periodicity option associated to the given number' do
      helper.periodicity_option(1).should eq "1 day"
    end

    it 'should return Undefined when there is no periodicity value' do
      helper.periodicity_option(nil).should eq "Undefined"
    end
  end

  describe 'calendar' do
    it 'should return an array with the number of days' do
      days = (1..31).to_a.map {|day| [day, day]}
      helper.day_options.should eq days
    end

    it 'should return an array with the number of months' do
      months = (1..12).to_a.map {|month| [month, month]}
      helper.month_options.should eq months
    end

    it 'should return a range of years' do
      years = (2013..2020).to_a.map {|year| [year, year]}
      helper.year_options.should eq years
    end
  end

end
