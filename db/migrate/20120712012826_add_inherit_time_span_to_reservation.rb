class AddInheritTimeSpanToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :inherit_time_span, :string
  end
end
