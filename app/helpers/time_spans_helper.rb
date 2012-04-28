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
end