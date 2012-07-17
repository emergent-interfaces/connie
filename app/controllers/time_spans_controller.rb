class TimeSpansController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @time_span = @event.build_time_span
  end

  def create
    @event = Event.find(params[:event_id])

    params[:time_span][:start_time] = Chronic.parse(params[:time_span][:start_time])
    params[:time_span][:end_time] = Chronic.parse(params[:time_span][:end_time])

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

  def chronic_parse
    data = {}
    data[:source] = params[:text]
    data[:result] = Chronic.parse(data[:source])

    # Attempt to fall back to basic parser
    begin
      data[:result] = DateTime.parse(data[:source]) unless data[:result]
    rescue
      data[:result] = nil
    end

    respond_to do |format|
      format.json { render :json => data.to_json }
    end
  end
end





