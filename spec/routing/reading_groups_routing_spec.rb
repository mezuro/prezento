require "rails_helper"

describe ReadingGroupsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/reading_groups/new').
                  to(controller: :reading_groups, action: :new) }

    it { is_expected.to route(:get, '/reading_groups').
                  to(controller: :reading_groups, action: :index) }

    it { is_expected.to route(:post, '/reading_groups').
                  to(controller: :reading_groups, action: :create) }

    it { is_expected.to route(:get, '/reading_groups/1').
                  to(controller: :reading_groups, action: :show, id: "1") }

    it { is_expected.to route(:get, '/reading_groups/1/edit').
                  to(controller: :reading_groups, action: :edit, id: "1") }

    it { is_expected.to route(:put, '/reading_groups/1').
                  to(controller: :reading_groups, action: :update, id: "1") }

    it { is_expected.to route(:delete, '/reading_groups/1').
                  to(controller: :reading_groups, action: :destroy, id: "1") }
  end
end
