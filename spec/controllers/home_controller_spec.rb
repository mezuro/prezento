require 'spec_helper'

describe HomeController do
  context 'Method' do
    context '#index' do
      before :each do
        get :index
      end

      it {should render_template(:index)}
    end
  end
end
