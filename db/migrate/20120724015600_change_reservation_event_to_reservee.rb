class ChangeReservationEventToReservee < ActiveRecord::Migration
  def change
    remove_column :reservations, :event_id
    add_column :reservations, :reservee_id, :integer
    add_column :reservations, :reservee_type, :string
  end
end
