class RolesController < ApplicationController
  def new
    @profile = Profile.find(params[:profile_id])
    @role = @profile.roles.build(:convention_id => params[:convention_id])
  end

  def create
    @role = Role.new(params[:role])
    @profile = @role.profile

    if @role.save
      redirect_to @profile, :notice => "Created role"
    else
      render :new
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @profile = @role.profile
    @role.destroy
    redirect_to @profile, :notice => "Deleted role"
  end
end
