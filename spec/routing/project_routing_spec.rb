require "spec_helper"

describe ProjectsController do
  describe "routing" do
    it 'should route to #new' do
      get('/projects/new').should route_to('projects#new')
    end

    it 'should route to #index' do
      get('/projects').should route_to('projects#index')
    end

    it 'should route to #create' do
      post('/projects').should route_to('projects#create')
    end

    it 'should route to #show' do
      get('/projects/1').should route_to('projects#show', :id => "1")
    end

    it 'should route to #edit' do
      get('/projects/1/edit').should route_to('projects#edit', :id => "1")
    end

    it 'should route to #update' do
      put('/projects/1').should route_to('projects#update', :id => "1")
    end

    it 'should route to #destroy' do
      delete('/projects/1').should route_to('projects#destroy', :id => "1")
    end
  end
end