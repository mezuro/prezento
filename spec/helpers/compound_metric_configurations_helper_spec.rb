require 'spec_helper'

describe CompoundMetricConfigurationsHelper, :type => :helper do
  describe 'scope_options' do
    it 'should return an array with the supported scope options' do
      expect(helper.scope_options).to eq [["Method","METHOD"], ["Class", "CLASS"], ["Package", "PACKAGE"], ["Software", "SOFTWARE"]]
    end
  end
end
