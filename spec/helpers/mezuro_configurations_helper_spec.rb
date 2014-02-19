require 'spec_helper'

describe MezuroConfigurationsHelper do
  describe 'mezuro_configuration_owner?' do
    before :each do
      @subject = FactoryGirl.build(:mezuro_configuration)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { helper.mezuro_configuration_owner?(@subject.id).should be_false }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownerships = []
        @ownerships.expects(:find_by_mezuro_configuration_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:mezuro_configuration_ownerships).returns(@ownerships)
      end

      it { helper.mezuro_configuration_owner?(@subject.id).should be_false }
    end

    context 'returns true if user is the mezuro_configuration owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:mezuro_configuration_ownership)
        @ownerships = []
        @ownerships.expects(:find_by_mezuro_configuration_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:mezuro_configuration_ownerships).returns(@ownerships)
      end

      it { helper.mezuro_configuration_owner?(@subject.id).should be_true }
    end
  end

  describe 'link to edit form' do
    context 'when the metric is native' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/mezuro_configurations/#{metric_configuration.configuration_id}/metric_configurations/#{metric_configuration.id}/edit\">Edit</a>"}

      it { helper.link_to_edit_form(metric_configuration, metric_configuration.configuration_id).should eq(response_link) }
    end

    context 'when the metric is compound' do
      let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/mezuro_configurations/#{compound_metric_configuration.configuration_id}/compound_metric_configurations/#{compound_metric_configuration.id}/edit\">Edit</a>"}

      it { helper.link_to_edit_form(compound_metric_configuration, compound_metric_configuration.configuration_id).should eq(response_link) }
    end
  end

  describe 'link to show page' do
    context 'when the metric is native' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/mezuro_configurations/#{metric_configuration.configuration_id}/metric_configurations/#{metric_configuration.id}\">Show</a>"}

      it { helper.link_to_show_page(metric_configuration, metric_configuration.configuration_id).should eq(response_link) }
    end

    context 'when the metric is compound' do
      let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/mezuro_configurations/#{compound_metric_configuration.configuration_id}/compound_metric_configurations/#{compound_metric_configuration.id}\">Show</a>"}

      it { helper.link_to_show_page(compound_metric_configuration, compound_metric_configuration.configuration_id).should eq(response_link) }
    end
  end
end
