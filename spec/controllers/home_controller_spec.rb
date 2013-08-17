require 'spec_helper'

describe HomeController do
  context 'Method' do
    context '#index' do
      before :each do
        Project.expects(:latest).with(5).returns([])

        get :index
      end

      it {should render_template(:index)}
    end
  end
end
