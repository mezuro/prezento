require 'rails_helper'

describe NameScriptPresenceValidator, :type => :model do
  describe 'methods' do
    describe 'validate' do
      let!(:compound_metric_configuration){ FactoryGirl.build(:compound_metric_configuration) }

      before :each do
        CodeUniquenessValidator.any_instance.stubs(:validate_each)
      end

      context 'with blank name' do
        before :each do
          compound_metric_configuration.metric.name = ""
        end

        it 'is expected to return a error for the name field' do
          compound_metric_configuration.save
          expect(compound_metric_configuration.errors[:name]).to include("can't be blank")
        end

        context 'with blank script' do
          before :each do
            compound_metric_configuration.metric.script = ""
          end

          it 'is expected to return a error for the name and script fields' do
            compound_metric_configuration.save
            expect(compound_metric_configuration.errors[:name]).to include("can't be blank")
            expect(compound_metric_configuration.errors[:script]).to include("can't be blank")
          end
        end
      end
    end
  end
end