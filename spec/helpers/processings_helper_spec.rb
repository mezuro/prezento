require 'rails_helper'

describe ProcessingsHelper, :type => :helper do
  describe 'humanize_eplased_time' do
    it 'should convert it to readable words' do
      expect(helper.humanize_eplased_time(6)).to eq('less than a minute')
    end
  end

  describe 'format_grade' do
    it 'should format a Float to a readable format' do
      expect(helper.format_grade(1.333333333)).to eq("1.33")
    end
  end

  describe 'find_range_snapshot' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id)}
    let(:metric_result) { FactoryGirl.build(:metric_result, {value: 6.0, metric_configuration: metric_configuration})}
    let(:range_snapshot_1_to_5) { FactoryGirl.build(:range_snapshot, {beginning: 1.0, end: 5.0}) }
    let(:range_snapshot_5dot1_to_10) { FactoryGirl.build(:range_snapshot, {beginning: 5.1, end: 10.0}) }
    let(:range_snapshot_10dot1_to_15) { FactoryGirl.build(:range_snapshot, {beginning: 10.1, end: 15.0}) }

    before :each do
      metric_result.expects(:metric_configuration).returns(metric_configuration)
      metric_configuration.expects(:kalibro_ranges).
                    returns([range_snapshot_1_to_5,
                             range_snapshot_5dot1_to_10,
                             range_snapshot_10dot1_to_15])
    end

    it 'should return the range snapshot in which the value was in between' do
      expect(helper.find_range_snapshot(metric_result)).to eq(range_snapshot_5dot1_to_10)
    end
  end

  describe 'format_module_name' do
    context 'when it is a String' do
      let(:name) { 'org' }

      it 'should not make any change' do
        expect(helper.format_module_name(name)).to eq(name)
      end
    end

    context 'when it is a Array' do
      let(:name) { ['org', 'mezuro'] }

      it "should return it's last element" do
        expect(helper.format_module_name(name)).to eq(name.last)
      end
    end

    context 'when it is a neither Array or String' do
      let(:name) { Object.new }

      it "should try to convert it to String" do
        name.expects(:to_s)

        helper.format_module_name(name)
      end
    end
  end
end
