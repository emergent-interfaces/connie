class PeriodsController < ApplicationController
  def new
    @convention = Convention.find(params[:convention_id])
    @period = @convention.periods.build
    @period.build_time_span
  end

  def create
    @convention = Convention.find(params[:convention_id])
    @period = @convention.periods.build(params[:period])

    if @period.save
      redirect_to settings_convention_path(@convention), :notice => "Period created"
    else
      render :new
    end
  end

  def edit
    @convention = Convention.find(params[:convention_id])
    @period = Period.find(params[:id])
  end

  def update
    @convention = Convention.find(params[:convention_id])
    @period = Period.find(params[:id])

    if @period.update_attributes(params[:period])
      redirect_to settings_convention_path(@convention), :notice => 'Period was successfully updated'
    else
      render :action => "edit"
    end
  end

  def destroy
    @convention = Convention.find(params[:convention_id])
    @period = Period.find(params[:id])
    @period.destroy
    redirect_to settings_convention_path(@convention), :notice => "Deleted #{@period.name}"
  end
end
