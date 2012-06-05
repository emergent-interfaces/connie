class Phone < ActiveRecord::Base
  validates_presence_of :number
  validates_length_of :number, :minimum => 10

  VALID_PHONE_TYPES = ["home", "mobile", "work", "fax"]
  validates :phone_type, :inclusion => {:in => VALID_PHONE_TYPES}
  belongs_to :phoneable, :polymorphic => true

  before_validation :keep_only_digits_in_number

  def keep_only_digits_in_number
    self.number = self.number.gsub(/[^0-9]/, "")
  end

  def phone_type_values
    @phone_type_values = [nil, "home", "mobile", "work", "fax"]
  end
end
