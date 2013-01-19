class ReservesTaggedRule < ActiveRecord::Base
  include RuleMixin

  validates_presence_of :tagged_type
  validates_presence_of :tag_name

  def satisfied?
    met_by.any? ? true : false
  end

  def met_by
    reservables = []

    event.reservations.each do |reservation|
      reservable = reservation.reservable
      if reservable.class == tagged_type.capitalize.constantize
        reservable.tags.each do |tag|
          reservables << reservable if tag.name == tag_name
        end
      end
    end

    reservables
  end

  def message
    if satisfied?
      :meets_tagged
    elsif event.reservations.empty?
      :no_reservation_of_type
    elsif violated?
      :no_reservation_with_tag
    end
  end
end
