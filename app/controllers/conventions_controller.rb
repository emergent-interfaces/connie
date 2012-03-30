class ConventionsController < ApplicationController
  def index
    @conventions = Convention.all
  end

  def show
    @convention = Convention.find(params[:id])
  end

  def new
    @convention = Convention.new
  end

  def create
    @convention = Convention.new(params[:convention])

    if @convention.save
      redirect_to @convention, :notice => "Convention created successfully"
    else
      render :action => "new"
    end

  end

  def edit
    @convention = Convention.find(params[:id])
  end

  def update
    @convention = Convention.find(params[:id])

    if @convention.update_attributes(params[:convention])
      redirect_to @convention, :notice => 'Convention was successfully updated'
    else
      render :action => "edit"
    end
  end

  def destroy
    @convention = Convention.find(params[:id])
    @convention.destroy
    redirect_to conventions_path
  end

  def set_as_default
    @convention = Convention.find(params[:id])
    session[:default_convention_id] = @convention.id
    redirect_to @convention
  end

  def remove_default
    session[:default_convention_id] = nil
    redirect_to conventions_path
  end
end
