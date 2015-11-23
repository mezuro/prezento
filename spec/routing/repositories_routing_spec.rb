require "rails_helper"

describe RepositoriesController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/repositories').
                  to(controller: :repositories, action: :create) }
    it { is_expected.to route(:get, '/repositories').
                  to(controller: :repositories, action: :index) }
    it { is_expected.to route(:get, '/repositories/new').
                  to(controller: :repositories, action: :new) }
    it { is_expected.to route(:get, '/repositories/1/edit').
                  to(controller: :repositories, action: :edit, id: 1) }
    it { is_expected.to route(:get, '/repositories/1').
                  to(controller: :repositories, action: :show, id: 1) }
    it { is_expected.to route(:get, '/repositories/1/modules/1').
                  to(controller: :repositories, action: :show, module_result_id: 1, id: 1) }
    it { is_expected.to route(:delete, '/repositories/1').
                  to(controller: :repositories, action: :destroy, id: 1) }
    it { is_expected.to route(:put, '/repositories/1').
                  to(controller: :repositories, action: :update, id: 1) }
    it { is_expected.to route(:get, '/repositories/1/state').
                  to(controller: :repositories, action: :state, id: 1) }
    it { is_expected.to route(:get, '/repositories/1/state_with_date').
                  to(controller: :repositories, action: :state_with_date, id: 1) }
    it { is_expected.to route(:get, '/repositories/1/process').
                  to(controller: :repositories, action: :process_repository, id: 1) }
    it { is_expected.to route(:get, '/repository_branches').
                  to(controller: :repositories, action: :branches) }
    it { is_expected.to route(:get, '/projects/1/repositories/new').
                  to(controller: :repositories, action: :new, project_id: 1) }
    it { is_expected.to route(:post, '/projects/1/repositories').
                  to(controller: :repositories, action: :create, project_id: 1) }
    it { is_expected.to route(:post, '/repositories/1/notify_push').
                  to(controller: :repositories, action: :notify_push, id: 1) }
    it { expect(post: '/repositories/1/notify_push.html').not_to be_routable }
  end
end
