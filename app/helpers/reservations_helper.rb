module ReservationsHelper
  def reservables_for_select
    reservables = Space.all + Profile.all
    reservables.map{|reservable| [reservable.name,"#{reservable.class}-#{reservable.id}"]}
  end
end