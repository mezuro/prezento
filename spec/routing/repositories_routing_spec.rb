require "rails_helper"

describe RepositoriesController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/projects/1/repositories').
                  to(controller: :repositories, action: :create, project_id: 1) }
    it { is_expected.to route(:get, '/projects/1/repositories/new').
                  to(controller: :repositories, action: :new, project_id: 1) }
    it { is_expected.to route(:get, '/projects/1/repositories/1/edit').
                  to(controller: :repositories, action: :edit, project_id: 1, id: 1) }
    it { is_expected.to route(:get, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :show, project_id: 1, id: 1) }
    it { is_expected.to route(:get, '/projects/1/repositories/1/modules/1').
                  to(controller: :repositories, action: :show, project_id: 1, module_result_id: 1, id: 1) }
    it { is_expected.to route(:delete, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :destroy, project_id: 1, id: 1) }
    it { is_expected.to route(:put, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :update, project_id: 1, id: 1) }
    it { is_expected.not_to route(:get, '/projects/1/repositories').
                  to(controller: :repositories, action: :index, project_id: 1) }
    it { is_expected.to route(:post, '/projects/1/repositories/1/state').
                  to(controller: :repositories, action: :state, project_id: 1, id: 1) }
    it { is_expected.to route(:post, '/projects/1/repositories/1/state_with_date').
                  to(controller: :repositories, action: :state_with_date, project_id: 1, id: 1) }
    it { is_expected.to route(:get, '/projects/1/repositories/1/process').
                  to(controller: :repositories, action: :process_repository, project_id: 1, id: 1) }
    it { is_expected.to route(:get, '/repository_branches').
                  to(controller: :repositories, action: :branches) }
   end
end
