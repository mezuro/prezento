require 'spec_helper'

describe ProcessingsHelper do
  describe 'humanize_eplased_time' do
    it 'should convert it to readable words' do
      helper.humanize_eplased_time(6000).should eq('less than a minute')
    end
  end

  describe 'format_grade' do
    it 'should format a Float to a readable format' do
      helper.format_grade(1.333333333).should eq("1.33")
    end
  end

  describe 'find_range_snapshot' do
    let(:metric_configuration_snapshot) { FactoryGirl.build(:metric_configuration_snapshot)}
    let(:metric_result) { FactoryGirl.build(:metric_result, {value: 6.0, configuration: metric_configuration_snapshot})}
    let(:range_snapshot_1_to_5) { FactoryGirl.build(:range_snapshot, {beginning: 1.0, end: 5.0}) }
    let(:range_snapshot_5dot1_to_10) { FactoryGirl.build(:range_snapshot, {beginning: 5.1, end: 10.0}) }
    let(:range_snapshot_10dot1_to_15) { FactoryGirl.build(:range_snapshot, {beginning: 10.1, end: 15.0}) }

    before :each do
      metric_configuration_snapshot.expects(:range_snapshot).
                    returns([range_snapshot_1_to_5,
                             range_snapshot_5dot1_to_10,
                             range_snapshot_10dot1_to_15])
    end

    it 'should return the range snapshot in which the value was in between' do
      helper.find_range_snapshot(metric_result).should eq(range_snapshot_5dot1_to_10)
    end
  end

  describe 'format_module_name' do
    context 'when it is a String' do
      let(:name) { 'org' }

      it 'should not make any change' do
        helper.format_module_name(name).should eq(name)
      end
    end

    context 'when it is a Array' do
      let(:name) { ['org', 'mezuro'] }

      it "should return it's last element" do
        helper.format_module_name(name).should eq(name.last)
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