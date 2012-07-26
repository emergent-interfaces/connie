class ScheduleReservable < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :reservable, :polymorphic => true
end
