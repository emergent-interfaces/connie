class TimeSpansController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @time_span = @event.build_time_span
  end

  def create
    @event = Event.find(params[:event_id])

    @time_span = @event.build_time_span(params[:time_span])

    if @time_span.save
      redirect_to @event, :notice => "Added dates"
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @time_span = @event.time_span
  end

  def update
    @event = Event.find(params[:event_id])
    @time_span = @event.time_span

    if @time_span.update_attributes(params[:time_span])
      redirect_to @event, :notice => 'Event schedule was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event.time_span.destroy
    redirect_to @event, :notice => "Removed date"
  end
end





