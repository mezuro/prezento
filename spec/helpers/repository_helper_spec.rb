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
end