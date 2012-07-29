module ApplicationHelper
  def edit_link_text(text=nil)
    link_text = content_tag(:i, "", :class=>"icon-pencil")
    link_text += " #{text}" if text
    link_text.html_safe
  end

  def delete_link_text(text=nil)
    link_text = content_tag(:i, "", :class=>"icon-remove")
    link_text += " #{text}" if text
    link_text.html_safe
  end

  def add_link_text(text=nil)
    link_text = content_tag(:i, "", :class=>"icon-plus")
    link_text += " #{text}" if text
    link_text.html_safe
  end
end
