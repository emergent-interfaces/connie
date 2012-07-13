class Reservation < ActiveRecord::Base
  belongs_to :reservable, :polymorphic => true
  belongs_to :event
  has_one :time_span, :as => :time_spannable

  validates_presence_of :reservable

  def reservable
    reservable_type.constantize.find(reservable_id) if reservable_id
  end

  alias_method :model_time_span, :time_span

  def time_span
    if inherit_time_span
      event.send(inherit_time_span)
    else
      model_time_span
    end
  end

  def scheduled?
    return true if time_span
    false
  end
end
