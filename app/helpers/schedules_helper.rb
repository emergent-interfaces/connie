module SchedulesHelper
  def reservation_width(reservation,hour_width,border)
    (hour_width)*reservation.time_span.duration(:hours) - border*2.0
  end

  def reservation_left(reservation,track_start_time,hour_width,border)
    (reservation.time_span.start_time.in_time_zone("EST") - track_start_time)*(hour_width)/3600.0+border
  end

  def reservation_popup_content(reservation)
    content = ""
    content << render(:partial => 'time_spans/inline', :locals=>{:time_span=>reservation.time_span, :text_only => true})
    content << "<br />".html_safe

    unless reservation.reservee.description == ""
      content << "#{truncate reservation.reservee.description, :length => 90, :separator => ' '}"
      content << "<br />".html_safe
    end

    content
  end
end