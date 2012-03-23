class ConsController < ApplicationController
  def index
    @cons = Con.all
  end

  def show
    @con = Con.find(params[:id])
  end

  def new
    @con = Con.new
  end

  def create
    @con = Con.new(params[:con])

    if @con.save
      redirect_to con, :notice => "Con created successfully"
    else
      render :action => "new"
    end
  end

  def edit
    @con = Con.find(params[:id])
  end

  def update
    @con = Con.find(params[:id])

    if @con.update_attributes(params[:con])
      redirect_to @con, :notice => 'Con was successfully updated'
    else
      render :action => "edit"
    end
  end

  def destroy
    @con = Con.find(params[:id])
    @con.destroy
    redirect_to cons_path
  end
end
