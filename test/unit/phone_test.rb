require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  should belong_to(:phoneable)

  should "accept number, extension, and type" do
    phone = Phone.new(:number => "1234567890", :extension => "123", :phone_type => "mobile")
    assert phone.save
  end

  should "require a number" do
    phone = Phone.new(:number => "")
    refute phone.save
  end

  ["123-456-7890", "(123) 456-7890", "A12DB3-456.78#90"].each do |number|
    should "save only numeric digits of #{number}" do
      phone = Phone.new(:number => number, :phone_type => 'mobile')
      assert phone.save
      assert_equal "1234567890", phone.number
    end
  end

  should "not save if less than 10 digits in number" do
    phone = Phone.new(:number => "123456789")
    refute phone.save
  end

  should "not save if type is not valid" do
    phone = Phone.new(:number => "1234567890", :phone_type => "apples")
    refute phone.save
  end
end
