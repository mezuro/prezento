RailsAdmin.config do |config|
  config.authorize_with do |controller|
    unless current_user.admin == true
      redirect_to main_app.root_path
      flash[:error] = t(:unauthorized)
    end
  end
  config.main_app_name = ["Mezuro", "Administrative Interface"]
  config.included_models = ["User", "Project", "ReadingGroup", "MetricConfiguration"]

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
