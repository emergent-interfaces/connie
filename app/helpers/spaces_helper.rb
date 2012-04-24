module SpacesHelper
  def space_breadcrumbs(space)
    trail = [link_to("Spaces",spaces_path)]

    space.ancestors.each do |ancestor|
      trail << link_to(ancestor.name,ancestor)
    end

    trail.join(" > ").html_safe
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
end
