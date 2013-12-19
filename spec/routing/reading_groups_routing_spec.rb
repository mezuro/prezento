require "spec_helper"

describe ReadingGroupsController do
  describe "routing" do
    it { should route(:get, '/reading_groups/new').
                  to(controller: :reading_groups, action: :new) }

    it { should route(:get, '/reading_groups').
                  to(controller: :reading_groups, action: :index) }

    it { should route(:post, '/reading_groups').
                  to(controller: :reading_groups, action: :create) }

    it { should route(:get, '/reading_groups/1').
                  to(controller: :reading_groups, action: :show, id: "1") }

    it { should route(:get, '/reading_groups/1/edit').
                  to(controller: :reading_groups, action: :edit, id: "1") }

    it { should route(:put, '/reading_groups/1').
                  to(controller: :reading_groups, action: :update, id: "1") }

    it { should route(:delete, '/reading_groups/1').
                  to(controller: :reading_groups, action: :destroy, id: "1") }
  end
end
