require "rails_helper"

describe HomeController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/').
                  to(controller: :home, action: :index) }
    it { is_expected.to route(:get, '/pt').
                  to(controller: :home, action: :index, locale: 'pt') }
  end
end