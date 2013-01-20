class AssigneesController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @assignee = @job.assignees.build
  end

  def create
    @job = Job.find(params[:job_id])
    @assignee = @job.assignees.build(params[:assignee])

    if @assignee.save
      redirect_to @job
    else
      render :action => "new"
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @assignee = Assignee.find(params[:id])
    @assignee.destroy
    redirect_to @job
  end
end
