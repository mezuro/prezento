require 'rails_helper'

describe CompoundMetricConfigurationsHelper, :type => :helper do
  describe 'scope_options' do
    it 'should return an array with the supported scope options' do
      expect(helper.scope_options).to eq [
         ["Function", "FUNCTION"], ["Method","METHOD"], ["Class", "CLASS"], ["Package", "PACKAGE"], ["Software", "SOFTWARE"]
      ]
    end
  end

  describe 'compound_metric_human_name' do
    context 'with one' do
      it 'is expected to return the class name internationalized' do
        expect(helper.compound_metric_human_name).to eq(I18n.t('activemodel.models.compound_metric_configuration.one'))
      end
    end

    context 'with more than one' do
      it 'is expected to return the class name internationalized and pluralized' do
        expect(helper.compound_metric_human_name(2)).to eq(I18n.t('activemodel.models.compound_metric_configuration.other'))
        expect(helper.compound_metric_human_name(50)).to eq(I18n.t('activemodel.models.compound_metric_configuration.other'))
      end
    end
  end

  describe 'compound_metric_human_attribute_name' do
    let(:attribute) { :name }

    it 'is expected to return the attribute name internationalized' do
      expect(helper.compound_metric_human_attribute_name(attribute)).to eq(I18n.t("activemodel.attributes.compound_metric_configuration.#{attribute}"))
    end
  end
end
