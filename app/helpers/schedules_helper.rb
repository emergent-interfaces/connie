module SchedulesHelper
  def reservation_width(reservation,hour_width,border)
    (hour_width)*reservation.event.time_span.duration(:hours) - border*2.0
  end

  def reservation_left(reservation,track_start_time,hour_width,border)
    (reservation.event.time_span.start_time.in_time_zone("EST") - track_start_time)*(hour_width)/3600.0+border
  end
end