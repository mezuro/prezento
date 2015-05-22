require 'rails_helper'

describe KalibroConfigurationsHelper, :type => :helper do
  describe 'kalibro_configuration_owner?' do
    before :each do
      @subject = FactoryGirl.build(:kalibro_configuration, :with_id)
    end

    context 'returns false if not logged in' do
      before :each do
        helper.expects(:user_signed_in?).returns(false)
      end
      it { expect(helper.kalibro_configuration_owner?(@subject.id)).to be_falsey }
    end

    context 'returns false if is not the owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @attributes = []
        @attributes.expects(:find_by_kalibro_configuration_id).with(@subject.id).returns(nil)

        User.any_instance.expects(:kalibro_configuration_attributes).returns(@attributes)
      end

      it { expect(helper.kalibro_configuration_owner?(@subject.id)).to be_falsey }
    end

    context 'returns true if user is the kalibro_configuration owner' do
      before :each do
        helper.expects(:user_signed_in?).returns(true)
        helper.expects(:current_user).returns(FactoryGirl.build(:user))

        @ownership = FactoryGirl.build(:kalibro_configuration_attributes)
        @attributes = []
        @attributes.expects(:find_by_kalibro_configuration_id).with(@subject.id).returns(@ownership)
        User.any_instance.expects(:kalibro_configuration_attributes).returns(@attributes)
      end

      it { expect(helper.kalibro_configuration_owner?(@subject.id)).to be_truthy }
    end
  end

  describe 'link to edit form' do
    context 'when the metric is native' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/kalibro_configurations/#{metric_configuration.kalibro_configuration_id}/metric_configurations/#{metric_configuration.id}/edit\">Edit</a>"}

      it { expect(helper.link_to_edit_form(metric_configuration, metric_configuration.kalibro_configuration_id)).to eq(response_link) }
    end

    context 'when the metric is compound' do
      let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/kalibro_configurations/#{compound_metric_configuration.kalibro_configuration_id}/compound_metric_configurations/#{compound_metric_configuration.id}/edit\">Edit</a>"}

      it { expect(helper.link_to_edit_form(compound_metric_configuration, compound_metric_configuration.kalibro_configuration_id)).to eq(response_link) }
    end
  end

  describe 'link to show page' do
    context 'when the metric is native' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/kalibro_configurations/#{metric_configuration.kalibro_configuration_id}/metric_configurations/#{metric_configuration.id}\">Show</a>"}

      it { expect(helper.link_to_show_page(metric_configuration, metric_configuration.kalibro_configuration_id)).to eq(response_link) }
    end

    context 'when the metric is compound' do
      let(:compound_metric_configuration) { FactoryGirl.build(:compound_metric_configuration_with_id) }
      let(:response_link) {"<a class=\"btn btn-info\" href=\"/kalibro_configurations/#{compound_metric_configuration.kalibro_configuration_id}/compound_metric_configurations/#{compound_metric_configuration.id}\">Show</a>"}

      it { expect(helper.link_to_show_page(compound_metric_configuration, compound_metric_configuration.kalibro_configuration_id)).to eq(response_link) }
    end
  end
end
