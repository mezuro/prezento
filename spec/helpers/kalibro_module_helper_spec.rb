require 'rails_helper'

describe KalibroModulesHelper, :type => :helper do
  describe 'sort_by_granularity_and_name' do
    let(:package) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_package)) }
    let(:class_a) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_class, name: 'a')) }
    let(:class_b) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_class, name: 'b')) }

    it 'is expected to order the ModuleResults by the Granularity first and then the KalibroModule name' do
      unordered_modules = [class_b, package, class_a]
      expect(helper.sort_by_granularity_and_name(unordered_modules)).to eq([package, class_a, class_b])
    end
  end
end