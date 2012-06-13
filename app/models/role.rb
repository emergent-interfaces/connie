class Role < ActiveRecord::Base
  belongs_to :convention
  validates_presence_of :convention

  validates_presence_of :name

  belongs_to :profile
  validates_presence_of :profile
end
