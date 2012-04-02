class ApplicationController < ActionController::Base
  protect_from_forgery

  def reset_app_session
    reset_session
  end
end
