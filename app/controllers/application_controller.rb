class ApplicationController < ActionController::Base
  protect_from_forgery

  require 'chronic_duration'

  def reset_app_session
    reset_session
    redirect_to conventions_path
  end
end
