class Reservation < ActiveRecord::Base
  belongs_to :reservable, :polymorphic => true
  belongs_to :event

  validates_presence_of :reservable

  def reservable
    Space.find(reservable_id) if reservable_id
  end
end
