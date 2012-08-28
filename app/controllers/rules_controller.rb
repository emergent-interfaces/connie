class RulesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])

    case params[:rule_type]
      when 'BeScheduledRule'
        @rule = BeScheduledRule.create
      when 'IsRelatedRule'
        @rule = IsRelatedRule.create(:relation => params[:relation],
                                     :related_event_id => params[:related_event_id])
      when 'DurationRule'
        min_duration = ChronicDuration.parse(params[:min_duration_str])
        max_duration = ChronicDuration.parse(params[:max_duration_str])
        @rule = DurationRule.create(:min_duration => min_duration, :max_duration => max_duration)

      when 'MeetOccupancyRule'
        @rule = MeetsOccupancyRule.create(:arrangement => params[:arrangement],
                                        :capacity => params[:capacity])
    end

    if @rule and !@rule.new_record?
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)
    end

    redirect_to @event
  end

  def destroy
    rule_class = params[:rule_type].constantize
    rule = rule_class.find(params[:rule_id])
    @event = rule.event
    rule.destroy
    redirect_to @event
  end
end