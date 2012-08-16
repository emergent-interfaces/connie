class AuthRequirementsController < ApplicationController
  def edit
    @convention = Convention.find(params[:convention_id])
    @auth_requirement = AuthRequirement.find(params[:id])
  end

  def update
    @convention = Convention.find(params[:convention_id])
    @auth_requirement = AuthRequirement.find(params[:id])

    respond_to do |format|
      if @auth_requirement.update_attributes(params[:auth_requirement])
        format.html {redirect_to settings_convention_path(@convention), :notice => "Updated authorization requirement"}
        format.json { respond_with_bip(@auth_requirement)}
      else
        format.html {render :edit}
        format.json { respond_with_bip(@auth_requirement)}
      end
    end
  end
end
