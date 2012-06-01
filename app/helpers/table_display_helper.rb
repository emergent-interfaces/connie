module TableDisplayHelper

  def table(collection, headers)
    output = "<table class='table'>\n"
    output << "\t<thead><tr>"
    headers.each do |h|
      output << "<td>#{h}</td>"
    end
    output << "</tr></thead>\n"

    output << "<tbody>"
    if collection.any?
      collection.each do |item|
        str = capture do
          proc.call(item, cycle("odd","even"))
        end
        output << str
      end
    else
      output << "\t<tr><td colspan=#{headers.count}>No records in database</td></tr>\n"
    end
    output << "</tbody>"

    output << "</table>"
    output.html_safe
  end
  
end