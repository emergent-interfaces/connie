module NavHelper
  def active_menu_class(controller)
    if params[:controller] == controller
      return "active"
    end
  end
end