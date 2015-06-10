require 'rails_helper'

describe TutorialsController do
  describe 'view' do
    context 'with a valid name' do
      let!(:name) { "analyzing" }

      before :each do
        get :view, name: name
      end

      it { is_expected.to render_template(name) }
      it { is_expected.to respond_with(:success) }
    end

    context 'with a invalid name' do
      let!(:name) { "invalid_name" }

      before :each do
        get :view, name: name
      end

      it { is_expected.to respond_with(:not_found) }
    end
  end
end
