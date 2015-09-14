require 'rails_helper'

describe KalibroModulesHelper, :type => :helper do
  describe 'sort_by_granularity_and_name' do
    let(:package) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_package)) }
    let(:class_b) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_class, name: 'b')) }
    let(:class_a) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_class, name: 'a')) }
    let(:function) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_function, name: 'c')) }
    let(:method) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_method, name: 'm')) }

    it 'is expected to order the ModuleResults by the Granularity first and then the KalibroModule name' do
      unordered_modules = [class_b, method, package, class_a, function]
      expect(helper.sort_by_granularity_and_name(unordered_modules)).to eq([package, class_a, class_b, method, function])
    end
  end

  describe 'ComparableGranularity' do
    describe 'methods' do
      describe '<=>' do
        subject { KalibroModulesHelper::ComparableGranularity.new(:FUNCTION) }
        let(:klass) { KalibroModulesHelper::ComparableGranularity.new(:CLASS) }
        let(:method) { KalibroModulesHelper::ComparableGranularity.new(:METHOD) }

        it 'is expected to place FUNCTION below all granularities' do
          expect(subject <=> klass).to eq(-1)
          expect(subject <=> method).to eq(-1)
        end
      end
    end
  end
end