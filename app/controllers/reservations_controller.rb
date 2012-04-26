class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build
  end

  def create
    params[:reservation][:reservable_type] = 'space'

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