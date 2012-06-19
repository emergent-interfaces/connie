class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build
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