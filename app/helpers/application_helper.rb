module ApplicationHelper
  def default_convention_name
    return "All conventions" unless session[:default_convention_id]
    Convention.find(session[:default_convention_id]).name
  end

  def default_convention
    return conventions_path unless session[:default_convention_id]
    Convention.find(session[:default_convention_id])
  end

  def filtered_events_path
    return events_path unless session[:default_convention_id]
    convention_events_path(default_convention)
  end
end
