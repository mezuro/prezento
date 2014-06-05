require 'spec_helper'

describe HomeController, :type => :controller do
  context 'Method' do
    context '#index' do
      before :each do
        Project.expects(:latest).with(5).returns([])

        get :index
      end

      it {is_expected.to render_template(:index)}
    end
  end
end
