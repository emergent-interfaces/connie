class AuthRequirement < ActiveRecord::Base
  attr_accessible :convention_id, :action, :model, :requirement
  attr_readonly :convention_id, :action, :model

  belongs_to :convention
  validates_presence_of :convention
  validates_presence_of :action
  validates_presence_of :model

  def requirements
    req_array = []

    requirement.split(",").each do |req|
      pieces = req.split(":")
      next unless pieces.count == 2
      pieces.each {|piece| piece.strip!}
      req_array << {:dept => pieces[0], :name => pieces[1]}
    end

    req_array
  end
end
