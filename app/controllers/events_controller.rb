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
    @event = Event.new
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
end
