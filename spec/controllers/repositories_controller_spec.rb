require 'spec_helper'

describe RepositoriesController do
  describe 'show' do
    let(:project) { FactoryGirl.build(:project) }
    let(:processing) { FactoryGirl.build(:processing) }
    subject { FactoryGirl.build(:repository) }

    before :each do
      subject.expects(:last_processing).returns(processing)
      Repository.expects(:find).at_least_once.with(subject.id).returns(subject)
      KalibroEntities::Entities::Configuration.expects(:find).with(subject.configuration_id) #FIXME: As soon as the Configuration model gets created refactor this!

      get :show, project_id: project.id, id: subject.id
    end

    it { should render_template(:show) }
  end
end
