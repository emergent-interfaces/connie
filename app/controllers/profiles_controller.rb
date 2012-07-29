class ProfilesController < ApplicationController
  respond_to :html, :json

  def index
    if params[:convention_id]
      @convention = Convention.find(params[:convention_id])
      @profiles = @convention.profiles
    else
      @profiles = Profile.all
    end

    @department_filter = params[:department]
    @profiles.select!{|profile| profile.departments.include?(@department_filter)} if @department_filter
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
    @profile.conventions << Convention.find(params[:convention_id]) if params[:convention_id]
  end

  def create
    @profile = Profile.new(params[:profile])

    if @profile.save
      redirect_to @profile, :notice => "Profile was successfully created"
    else
      render :action => "new"
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, :notice => 'Profile was successfully updated' }
        format.json { respond_with_bip @profile }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip @profile }
      end
    end
  end

  def destroy
    Profile.find(params[:id]).destroy
    redirect_to profiles_path, :notice => 'Profile destroyed'
  end
end
