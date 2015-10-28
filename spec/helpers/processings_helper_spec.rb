require 'rails_helper'

def make_range(b, e)
  FactoryGirl.build(:range_snapshot, beginning: b, end: e)
end

describe ProcessingsHelper, :type => :helper do
  describe 'humanize_elapsed_time' do
    it 'should convert it to readable words' do
      expect(helper.humanize_elapsed_time(6)).to eq('less than a minute')
    end
  end

  describe 'format_grade' do
    it 'should format a Float to a readable format' do
      expect(helper.format_grade(1.333333333)).to eq("1.33")
    end
  end

  describe 'find_range_snapshot' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id)}
    let(:tree_metric_result) { FactoryGirl.build(:tree_metric_result, {value: 6.0, metric_configuration: metric_configuration})}

    before :each do
      tree_metric_result.expects(:metric_configuration).returns(metric_configuration)
      metric_configuration.expects(:kalibro_ranges).returns(range_snapshots)
    end

    context 'with two finite boundaries' do
      let!(:range_snapshots) { [make_range(1.0, 5.0), make_range(5.1, 10.0), make_range(10.1, 15.0)] }

      it 'should return the range snapshot which contains the value' do
        expect(helper.find_range_snapshot(tree_metric_result)).to eq(range_snapshots[1])
      end
    end

    context 'with unbounded ranges' do
      let!(:range_snapshots) { [make_range('-INF', 0.0), make_range(0, 'INF')] }

      it 'should return the range snapshot which contains the value' do
        expect(helper.find_range_snapshot(tree_metric_result)).to eq(range_snapshots[1])
      end
    end

    context 'with an universal range' do
      let!(:range_snapshots) { [make_range('-INF', 'INF')] }

      it 'should return the range snapshot which contains the value' do
        expect(helper.find_range_snapshot(tree_metric_result)).to eq(range_snapshots[0])
      end
    end

    context 'with incomplete ranges' do
      let!(:range_snapshots) { [make_range('-INF', 6.0), make_range(6.1, 'INF')] }

      it 'should return nil' do
        expect(helper.find_range_snapshot(tree_metric_result)).to be_nil
      end
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
