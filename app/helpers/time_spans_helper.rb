module TimeSpansHelper
  def confidence_string_for(confidence_index)
    TimeSpan::CONFIDENCES.key(confidence_index)
  end

  def time_span_parent_array
    case
      when (@event and @activity) then [@event, @activity, @time_span]
      when @event then [@event, @time_span]
    end
  end

  def condensed_time_span(time_span)
    str = ""
    start_datetime = time_span.start_time
    end_datetime = time_span.end_time

    if ( start_datetime.to_date == end_datetime.to_date)
      str << "#{l start_datetime}"
      str << " <span class='subtle'>to</span> "
      str << "#{l end_datetime, :format=>:only_time}"
    else
      str << "#{l start_datetime}"
      str << " <span class='subtle'>to</span> "
      str << "#{l end_datetime}"
    end

    str.html_safe
  end
end