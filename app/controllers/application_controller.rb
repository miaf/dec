class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :get_languages
  # before_action :set_locale_from_url
  helper_method :current_user

	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end
	
  private
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def get_languages
    @languages = Language.all
  end
end
