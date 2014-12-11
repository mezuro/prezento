require 'rails_helper'

describe ResourceFinder, type: :controller do
  describe 'find_resource' do
    let(:klass) { mock('Resource') }
    let(:id) { 1 }
    let!(:projects_controller) {ProjectsController.new}

    before do
      projects_controller.extend(ResourceFinder)
    end

    context 'when the resource exists' do
      let!(:resource) { mock('resource') }

      before :each do
        klass.expects(:find).with(id).returns(resource)
      end

      it 'is expect to return the resource' do
        expect(projects_controller.find_resource(klass, id)).to eq(resource)
      end
    end

    context 'when the resource does not exists' do
      before :each do
        klass.expects(:find).with(id).raises(KalibroGatekeeperClient::Errors::RecordNotFound)
      end

      # FIXME: this is not the best test, but it it's the closest we can think of
      #        full coverage is achieved through projects_controller_spec.rb
      it 'is expected to render the 404 page' do
        projects_controller.expects(:respond_to)

        projects_controller.find_resource(klass, id)
      end
    end
  end
end