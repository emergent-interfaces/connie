module SpacesHelper
  def space_breadcrumbs(space)
    trail = [link_to("Spaces",spaces_path)]

    space.ancestors.each do |ancestor|
      trail << link_to(ancestor.name,ancestor)
    end

    trail.join(" > ").html_safe
  end

  def ancestors_list(space)
    space.ancestors.reverse.collect {|a| link_to a.name, a}.join(", ").html_safe
  end

  def display_segment(node)
    html = "<li>"
    node_class = node.children.length == 0 ? "file" : "folder"
    html << "<span class=\"#{node_class}\">"
    html << link_to(node.name, node)
    html << "</span>"
    html << "<ul id=\"children_of_#{h(node.id)}\">"

    node.children.each do |child_node|
      html << display_segment(child_node)
    end

    html << "</ul></li>"
    html.html_safe
  end

  def location(space)
    ancestors = space.ancestors

    loc = ancestors.reverse.collect {|a| in_space_text(a.name,a.space_type)}.join(" ")
  end

  def in_space_text(name,type)
    text = ""

    case type
      when 'building'
        if name.downcase.include?('building')
          text = "in the #{name}"
        else
          text = "in the #{name} building"
        end
      when 'floor'
        if name.downcase.include?('floor')
          text = "on the #{name}"
        else
          text = "on the #{name} floor"
        end
      when 'area'
        text = "in the #{name}"
      when 'room'
        if name.downcase.include?('room') or
           name.downcase.include?('hall') or
           name.downcase.include?('lobby')
          text = "in the #{name}"
        else
          text = "in #{name}"
        end
    end

    text
  end

end
