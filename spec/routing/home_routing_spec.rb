require "spec_helper"

describe HomeController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/').
                  to(controller: :home, action: :index) }
  end
end