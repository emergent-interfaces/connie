class EventsController < ApplicationController
  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @events = @convention.events
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new()
    @event.conventions << Convention.find(params[:convention_id]) if params[:convention_id]
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      redirect_to @event, :notice => "Event was successfully created"
    else
      render :action => "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => 'Event was successfully updated'
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, :notice => "Event deleted"
  end

  def create_rule
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
    end

    if @rule
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)
    end

    redirect_to @event
  end
end
