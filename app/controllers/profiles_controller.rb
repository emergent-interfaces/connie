class ProfilesController < ApplicationController
  respond_to :html, :json

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
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
