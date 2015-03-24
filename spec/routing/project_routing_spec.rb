require "rails_helper"

describe ProjectsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/projects/new').
                  to(controller: :projects, action: :new) }

    it { is_expected.to route(:get, '/projects').
                  to(controller: :projects, action: :index) }

    it { is_expected.to route(:get, '/pt/projects').
                  to(controller: :projects, action: :index, locale: 'pt') }

    it { is_expected.to route(:post, '/projects').
                  to(controller: :projects, action: :create) }

    it { is_expected.to route(:get, '/projects/1').
                  to(controller: :projects, action: :show, id: "1") }

    it { is_expected.to route(:get, '/projects/1/edit').
                  to(controller: :projects, action: :edit, id: "1") }

    it { is_expected.to route(:put, '/projects/1').
                  to(controller: :projects, action: :update, id: "1") }

    it { is_expected.to route(:delete, '/projects/1').
                  to(controller: :projects, action: :destroy, id: "1") }
  end
end