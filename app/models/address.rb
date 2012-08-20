class Address < ActiveRecord::Base
  attr_accessible :text, :addressable

  belongs_to :addressable, :polymorphic => true
end
