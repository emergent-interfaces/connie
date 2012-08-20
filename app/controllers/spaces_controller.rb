class SpacesController < ApplicationController
  respond_to :html, :json

  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :index]

  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @spaces = @convention.spaces.accessible_by(current_ability)
    else
      @spaces = Space.accessible_by(current_ability)
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
    @space.build_own_address
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
    @space.build_own_address unless @space.address
  end

  def update
    @space = Space.find(params[:id])

    respond_to do |format|
      if @space.update_attributes(params[:space])
        format.html {redirect_to @space, :notice => "Space updated"}
        format.json {respond_with_bip @space}
      else
        format.html {render :action => 'edit'}
        format.json {respond_with_bip @space}
      end
    end
  end

  def destroy
    @space = Space.find(params[:id])
    @space.destroy
    redirect_to spaces_path
  end
end
