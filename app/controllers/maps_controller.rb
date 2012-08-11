class MapsController < ApplicationController
  def new
    @space = Space.find(params[:space_id])
    @map = @space.maps.build
  end

  def create
    @space = Space.find(params[:space_id])
    @map = @space.maps.build(params[:map])

    if @map.save
      redirect_to [@space, @map], :notice => "Map created successfully"
    else
      render :action => :new
    end
  end

  def show
    @space = Space.find(params[:space_id])
    @map = Map.find(params[:id])
  end

  def edit
    @space = Space.find(params[:space_id])
    @map = Map.find(params[:id])
  end

  def update
    @space = Space.find(params[:space_id])
    @map = Map.find(params[:id])

    if @map.update_attributes(params[:map])
      redirect_to [@space, @map], :notice => "Space updated"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @space = Space.find(params[:space_id])
    map = Map.find(params[:id])
    map.destroy
    redirect_to @space, :notice => "Removed map from #{@space.name}"
  end
end
