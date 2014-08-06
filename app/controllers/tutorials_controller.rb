class TutorialsController < ApplicationController
  def view
    render params[:name]
  end
end
