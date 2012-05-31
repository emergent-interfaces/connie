class PhonesController < ApplicationController
  respond_to :html, :json

  def new
    @phoneable = find_phoneable
    @phone = @phoneable.phones.build
  end

  def create
    @phoneable = find_phoneable
    @phone = @phoneable.phones.build(params[:phone])

    if @phone.save
      redirect_to @phoneable, :notice => "Phone was successfully created"
    else
      render :action => "new"
    end
  end

  def edit
    @phoneable = find_phoneable
    @phone = Phone.find(params[:id])
  end

  def update
    @phoneable = find_phoneable
    @phone = Phone.find(params[:id])

    respond_to do |format|
      if @phone.update_attributes(params[:phone])
        format.html { redirect_to @phoneable, :notice => 'Phone was successfully updated' }
        format.json { respond_with_bip @phone }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip @phone }
      end
    end
  end

  def destroy
    @phoneable = find_phoneable
    @phone = Phone.find(params[:id])
    @phone.destroy
    redirect_to @phoneable, :notice => "Phone deleted"
  end

  private

  def find_phoneable
    case
      when params[:profile_id] then Profile.find(params[:profile_id])
    end
  end
end
