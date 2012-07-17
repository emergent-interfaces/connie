class Reservation < ActiveRecord::Base
  belongs_to :reservable, :polymorphic => true
  belongs_to :event

  has_one :own_time_span, :as => :time_spanable, :class_name => "TimeSpan"
  accepts_nested_attributes_for :own_time_span, :reject_if => proc{|attrs| attrs['start_time'].blank?}
  validates :own_time_span, :presence => true, :unless => :inherit_time_span

  validates_presence_of :reservable

  def reservable
    reservable_type.constantize.find(reservable_id) if reservable_id
  end

  def time_span
    if inherit_time_span
      event.time_span
    else
      own_time_span
    end
  end

  def scheduled?
    return true if time_span
    false
  end
end
