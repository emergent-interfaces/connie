class AuthRequirement < ActiveRecord::Base
  attr_accessible :convention_id, :action, :model, :requirement
  attr_readonly :convention_id, :action, :model

  belongs_to :convention
  validates_presence_of :convention
  validates_presence_of :action

  def requirements
    req_array = []
    return req_array unless requirement

    requirement.split(",").each do |req|
      pieces = req.split(":")
      next unless pieces.count == 2
      pieces.each {|piece| piece.strip!}
      req_array << {:dept => pieces[0], :name => pieces[1]}
    end

    req_array
  end

  def met_by(role)
    requirements.each do |req|
      next if convention != role.convention
      next if req[:dept] != "*" and role.department != req[:dept]
      next if req[:name] != "*" and role.name != req[:name]
      return true
    end

    false
  end

  def met_by_any_of(roles)
    roles.each { |role| return true if met_by(role) }
    false
  end
end
