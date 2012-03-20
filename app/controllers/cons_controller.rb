class ConsController < ApplicationController
  def create
    con = Con.new(params[:con])

    if con.save!
      redirect_to con, :notice => "Con created successfully"
    end
  end

  def update
    @con = Con.find(params[:id])

    if @con.update_attributes(params[:con])
      redirect_to @con, :notice => 'Con was successfully update'
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
