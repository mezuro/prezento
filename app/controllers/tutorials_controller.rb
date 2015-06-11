class TutorialsController < ApplicationController
  rescue_from ActionView::MissingTemplate, with: :not_found

  def view
    render params[:name]
  end
end
