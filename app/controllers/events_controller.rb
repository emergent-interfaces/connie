class EventsController < ApplicationController
  respond_to :html, :json

  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :index]

  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @events = @convention.events.accessible_by(current_ability)
    else
      @events = Event.accessible_by(current_ability)
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

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => 'Event was successfully updated' }
        format.json { respond_with_bip @event }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip @event }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, :notice => "Event deleted"
  end

end
