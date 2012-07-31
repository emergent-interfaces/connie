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

  def default_convention
    verify_default_convention
    return conventions_path unless default_convention_set?
    Convention.find(session[:default_convention_id])
  end
  helper_method :default_convention

  def default_convention_set?
    verify_default_convention
    session[:default_convention_id] ? true : false
  end
  helper_method :default_convention_set?

  def verify_default_convention
    begin
      Convention.find(session[:default_convention_id])
    rescue
      session[:default_convention_id] = nil
    end
  end
end
