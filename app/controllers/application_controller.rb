class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_timezone

  require 'chronic_duration'

  def reset_app_session
    reset_session
    redirect_to conventions_path
  end

  def set_timezone
    Time.zone = "EST"
  end

  def index
    redirect_to default_convention
  end

  helper_method :default_convention
  def default_convention
    return conventions_path unless session[:default_convention_id]
    Convention.find(session[:default_convention_id])
  end

  helper_method :default_convention_set?
  def default_convention_set?
    session[:default_convention_id] ? true : false
  end

end
