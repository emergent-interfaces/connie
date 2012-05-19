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
end
