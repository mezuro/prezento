require "spec_helper"

describe ProjectsController do
  describe "routing" do
    it { should route(:get, '/projects/new').
                  to(controller: :projects, action: :new) }

    it { should route(:get, '/projects').
                  to(controller: :projects, action: :index) }

    it { should route(:post, '/projects').
                  to(controller: :projects, action: :create) }

    it { should route(:get, '/projects/1').
                  to(controller: :projects, action: :show, id: "1") }

    it { should route(:get, '/projects/1/edit').
                  to(controller: :projects, action: :edit, id: "1") }

    it { should route(:put, '/projects/1').
                  to(controller: :projects, action: :update, id: "1") }

    it { should route(:delete, '/projects/1').
                  to(controller: :projects, action: :destroy, id: "1") }
  end
end