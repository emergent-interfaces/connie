module ReservableMixin
  
  def self.included(base)
    base.has_many :reservations, :as => :reservable, :dependent => :destroy
  end

  #def reservations_overlapping(range)
  #  overlapping = reservations.select {|r| r.range.overlap?(range)}
  #end

end