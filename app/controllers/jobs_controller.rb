class JobsController < ApplicationController
  respond_to :html, :json

  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @jobs = @convention.jobs
    else
      @jobs = Job.all
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @job.conventions << Convention.find(params[:convention_id]) if params[:convention_id]
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      redirect_to @job, :notice => "Job was successfully created"
    else
      render :action => "new"
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, :notice => 'Job was successfully updated' }
        format.json { respond_with_bip @job }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip @job }
      end
    end
  end

  def destroy
    Job.find(params[:id]).destroy
    redirect_to jobs_path, :notice => 'Job destroyed'
  end
end
