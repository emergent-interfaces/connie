module SchedulesHelper
  def reservation_width(reservation,hour_width,border)
    (Float(hour_width)-Float(border)*2.0)*reservation.event.time_span.duration(:hours)
  end

  def reservation_left(reservation,track_start_time,hour_width,border)
    (reservation.event.time_span.start_time - track_start_time)*(Float(hour_width))/3600.0+border
  end
end