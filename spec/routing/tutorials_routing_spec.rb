require "spec_helper"

describe TutorialsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/tutorials/project').
                  to(controller: :tutorials, action: :view, name: "project") }
  end
end