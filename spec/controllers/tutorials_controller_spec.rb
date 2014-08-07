require 'spec_helper'

describe TutorialsController do
  describe 'view' do
    let!(:name) { "analyzing" }

    before :each do
      get :view, name: name
    end

    it { is_expected.to render_template(name) }
    it { is_expected.to respond_with(:success) }
  end
end
