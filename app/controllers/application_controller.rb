require 'http_accept_language'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :error, :alert

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale

  class << self
    # This is necessary for correct devise routing with locales: https://github.com/plataformatec/devise/wiki/How-To:--Redirect-with-locale-after-authentication-failure
    def default_url_options
      locale_options
    end

    def locale_options
      { locale: I18n.locale }
    end
  end

  # This happens after the *_url *_path helpers
  def default_url_options
    self.class.locale_options
  end

  protected

  # :nocov:
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def set_locale
    I18n.locale = (
      params[:locale] ||
      http_accept_language.compatible_language_from(I18n.available_locales) ||
      I18n.default_locale
    )
  end
end
