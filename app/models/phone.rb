class Phone < ActiveRecord::Base
  validates_presence_of :number
  validates_length_of :number, :minimum => 10
  validate :type_is_valid
  belongs_to :phoneable, :polymorphic => true

  before_validation :keep_only_digits_in_number

  def keep_only_digits_in_number
    self.number = self.number.gsub(/[^0-9]/, "")
  end

  def type_is_valid
    self.phone_type ||= ""
    errors.add(:phone_type, "is not a valid option") unless phone_type_values.include?(self.phone_type)
  end

  def phone_type_values
    @phone_type_values = ["", "home", "mobile", "work", "fax"]
  end
end
