module ApplicationHelper
  def default_convention_name
    return "All conventions" unless session[:default_convention_id]
    Convention.find(session[:default_convention_id]).name
  end

  def default_convention
    return conventions_path unless session[:default_convention_id]
    Convention.find(session[:default_convention_id])
  end

  def default_convention_set?
    session[:default_convention_id] ? true : false
  end

  def filtered_events_path
    return events_path unless default_convention_set?
    convention_events_path(default_convention)
  end

  def filtered_spaces_path
      return spaces_path unless default_convention_set?
      convention_spaces_path(default_convention)
    end
end
