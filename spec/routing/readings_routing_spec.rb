require "spec_helper"

describe ReadingsController do
  describe "routing" do
    it { should route(:post, '/reading_groups/1/readings').
                  to(controller: :readings, action: :create, reading_group_id: 1) }
    it { should route(:get, '/reading_groups/1/readings/new').
                  to(controller: :readings, action: :new, reading_group_id: 1) }
    it { should route(:get, '/reading_groups/1/readings/1/edit').
                  to(controller: :readings, action: :edit, reading_group_id: 1, id: 1) }
    it { should_not route(:get, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :show, reading_group_id: 1, id: 1) }
    it { should route(:delete, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :destroy, reading_group_id: 1, id: 1) }
    it { should route(:put, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :update, reading_group_id: 1, id: 1) }
    it { should_not route(:get, '/reading_groups/1/readings').
                    to(controller: :readings, action: :index, reading_group_id: 1) }
  end
end
