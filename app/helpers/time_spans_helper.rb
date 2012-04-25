module TimeSpansHelper
  def time_span_summary(time_span)
    text = "#{time_span.start_time}"
    text << " to #{time_span.end_time}"

    if time_span.confidence < 2
      text << " (#{confidence_string_for(time_span.confidence)})"
    end

    text
  end

  def confidence_string_for(confidence_index)
    TimeSpan::CONFIDENCES.key(confidence_index)
  end

  def time_span_parent_array
    case
      when (@event and @activity) then [@event, @activity, @time_span]
      when @event then [@event, @time_span]
    end
  end
end