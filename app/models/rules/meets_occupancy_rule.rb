class MeetsOccupancyRule < ActiveRecord::Base
  include RuleMixin

  validates_presence_of :arrangement
  validates_presence_of :capacity

  attr_accessible :arrangement, :capacity

  def satisfied?
    met_by.any? ? true : false
  end

  def message
    if satisfied?
      :meets_occupancy
    elsif event.reservations.empty?
      :no_spaces_reserved
    elsif violated?
      :no_satisfactory_space_reserved
    end
  end

  def met_by
    spaces = []

    event.reservations.each do |reservation|
      reservable = reservation.reservable
      if reservable.class == Space
        puts "TEST: #{reservable.name}"
        if arrangement == "seated"
          next unless reservable.occupany_seated
          spaces << reservable if reservable.occupancy_seated > capacity
        elsif arrangement == "standing"
          next unless reservable.occupancy_standing
          spaces << reservable if reservable.occupancy_standing > capacity
        end
      end
    end

    spaces
  end
end
