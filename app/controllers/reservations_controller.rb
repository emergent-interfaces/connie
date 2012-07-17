class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build

    @reservation.inherit_time_span = true
    @reservation.build_own_time_span
  end

  def create
    reservable = params[:reservation][:reservable_id].split('-')
    params[:reservation][:reservable_type] = reservable[0]
    params[:reservation][:reservable_id] = reservable[1]

    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build(params[:reservation])

    if @reservation.save
      redirect_to @event, :notice => "Reservation created"
    else
      @reservable_compound_id = "#{reservable[0]}-#{reservable[1]}"
      @reservation.build_own_time_span unless @reservation.own_time_span
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to @event
  end
end