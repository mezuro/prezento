require 'spec_helper'

describe CompoundMetricConfigurationsHelper do
  describe 'scope_options' do
    it 'should return an array with the supported scope options' do
      helper.scope_options.should eq [["Method","METHOD"], ["Class", "CLASS"], ["Package", "PACKAGE"], ["Software", "SOFTWARE"]]
    end
  end
end
