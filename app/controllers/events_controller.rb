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

    @rule = params[:rule_type].constantize.new
    @event.rule_assignments << RuleAssignment.new(:rule => @rule)

    redirect_to @event
  end
end
