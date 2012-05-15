class SpacesController < ApplicationController
  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @spaces = @convention.spaces
    else
      @spaces = Space.all
    end
  end

  def show
    @space = Space.find(params[:id])

    respond_to do |format|
      format.html {}
      format.ics {render :text => @space.icalendar.to_ical}
    end

  end

  def new
    @space = Space.new
    @space.conventions << Convention.find(params[:convention_id]) if params[:convention_id]
  end

  def create
    @space = Space.new(params[:space])

    #unless @space.parent_id
    #  Space.create!(:name => 'world') unless Space.find_by_name('world')
    #  @space.parent_id = Space.find_by_name('world').id
    #end

    if @space.save
      redirect_to @space, :notice => "Space created successfully"
    else
      render :action => :new
    end
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.find(params[:id])

    if @space.update_attributes(params[:space])
      redirect_to @space, :notice => "Space updated"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @space = Space.find(params[:id])
    @space.destroy
    redirect_to spaces_path
  end
end
