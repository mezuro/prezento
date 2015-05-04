require 'rails_helper'

describe ApplicationHelper, :type => :helper do
  describe 't_hint' do
    let(:class_key) { :compound_metric_configuration }
    let(:attribute_key) { :script }

    context 'without class_key' do
      let!(:translation) { "translated test" }

      before :each do
        helper.expects(:t).with("activemodel.hints.#{helper.controller_name}.#{attribute_key}", {}).returns(translation)
      end

      it 'is expected to return the hint for the given attribute' do
        expect(helper.t_hint(attribute_key)).to eq(translation)
      end
    end

    context 'with class_key' do
      it 'is expected to return the hint for the given attribute' do
        expect(helper.t_hint(attribute_key, class_key)).to eq(I18n.t("activemodel.hints.#{class_key}.#{attribute_key}"))
      end
    end
  end

  describe 't_action' do
    let!(:model) { mock "Model" }
    let!(:model_name) { mock "Model Name" }
    let(:action) { :edit }

    before :each do
      model.expects(:model_name).twice.returns(model_name)
      model_name.expects(:i18n_key).returns(:model)
      model_name.expects(:human).with(count: 1).returns("Model")
      helper.expects(:t).with("helpers.submit.model.edit", {default: "helpers.submit.edit".to_sym, model: "Model"}).returns("Edit Model")
    end

    it "is expected to return the Model's edit action translation" do
      expect(helper.t_action(action, model)).to eq("Edit Model")
    end
  end
end
