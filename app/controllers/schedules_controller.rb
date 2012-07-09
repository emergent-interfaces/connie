class SchedulesController < ApplicationController
  def index

  end

  def show
    @start_time = DateTime.parse(params[:start])
    @end_time = DateTime.parse(params[:end])

    @hours = hours(@start_time.in_time_zone, @end_time.in_time_zone)

    @spaces = params[:space_ids].split(',').collect {|id| Space.find(id)}
  end

  def hours(start_time, end_time)
    hour = start_time.change(:sec => 0, :min => 0)

    hours = []

    while hour < end_time
      hours << hour
      hour += 1.hour
    end

    hours << hour

    hours
  end

end