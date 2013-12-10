require "spec_helper"

describe RepositoriesController do
  describe "routing" do
    it { should route(:post, '/projects/1/repositories').
                  to(controller: :repositories, action: :create, project_id: 1) }
    it { should route(:get, '/projects/1/repositories/new').
                  to(controller: :repositories, action: :new, project_id: 1) }
    it { should route(:get, '/projects/1/repositories/1/edit').
                  to(controller: :repositories, action: :edit, project_id: 1, id: 1) }
    it { should route(:get, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :show, project_id: 1, id: 1) }
    it { should route(:get, '/projects/1/repositories/1/modules/1').
                  to(controller: :repositories, action: :show, project_id: 1, module_result_id: 1, id: 1) }
    it { should route(:delete, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :destroy, project_id: 1, id: 1) }
    it { should route(:put, '/projects/1/repositories/1').
                  to(controller: :repositories, action: :update, project_id: 1, id: 1) }
    it { should_not route(:get, '/projects/1/repositories').
                  to(controller: :repositories, action: :index, project_id: 1) }
    it { should route(:post, '/projects/1/repositories/1/state').
                  to(controller: :repositories, action: :state, project_id: 1, id: 1) }
    it { should route(:get, '/projects/1/repositories/1/reprocess').
                  to(controller: :repositories, action: :reprocess, project_id: 1, id: 1) }
  end
end
