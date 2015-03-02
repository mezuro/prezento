class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :error, :alert

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  protected

  # :nocov:
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def set_locale
    if (params[:locale])
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
    end
  end
end
