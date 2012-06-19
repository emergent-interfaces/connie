class Reservation < ActiveRecord::Base
  belongs_to :reservable, :polymorphic => true
  belongs_to :event

  validates_presence_of :reservable

  def reservable
    reservable_type.constantize.find(reservable_id) if reservable_id
  end
end
