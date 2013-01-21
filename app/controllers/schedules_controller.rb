class SchedulesController < ApplicationController
  respond_to :html, :json
  skip_before_filter :authenticate_user!
  before_filter :authenticate_user!, :except => [:show]

  def index

  end

  def new
    @convention = Convention.find(params[:convention_id])
    @schedule = @convention.schedules.build
    @schedule.build_time_span
  end

  def create
    @convention = Convention.find(params[:convention_id])
    @schedule = @convention.schedules.build(params[:schedule])

    if @schedule.save
      redirect_to [@convention, @schedule], :notice => "Schedule was successfully created"
    else
      render :action => "new"
    end
  end

  def show
    @convention = Convention.find(params[:convention_id])
    @schedule = Schedule.find(params[:id])
    authenticate_user! unless @schedule.public?

    respond_with(@schedule)
  end

  def edit
    @convention = Convention.find(params[:convention_id])
    @schedule = Schedule.find(params[:id])
  end

  def update
    @convention = Convention.find(params[:convention_id])
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to [@convention, @schedule], :notice => 'Schedule was successfully updated' }
        format.json { respond_with_bip @event }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip @event }
      end
    end
  end

  def destroy
    @convention = Convention.find(params[:convention_id])
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to @convention, :notice => 'Schedule deleted'
  end
end