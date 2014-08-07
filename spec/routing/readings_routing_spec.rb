require "rails_helper"

describe ReadingsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/reading_groups/1/readings').
                  to(controller: :readings, action: :create, reading_group_id: 1) }
    it { is_expected.to route(:get, '/reading_groups/1/readings/new').
                  to(controller: :readings, action: :new, reading_group_id: 1) }
    it { is_expected.to route(:get, '/reading_groups/1/readings/1/edit').
                  to(controller: :readings, action: :edit, reading_group_id: 1, id: 1) }
    it { is_expected.not_to route(:get, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :show, reading_group_id: 1, id: 1) }
    it { is_expected.to route(:delete, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :destroy, reading_group_id: 1, id: 1) }
    it { is_expected.to route(:put, '/reading_groups/1/readings/1').
                  to(controller: :readings, action: :update, reading_group_id: 1, id: 1) }
    it { is_expected.not_to route(:get, '/reading_groups/1/readings').
                    to(controller: :readings, action: :index, reading_group_id: 1) }
  end
end
