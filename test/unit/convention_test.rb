require 'test_helper'

class ConventionTest < ActiveSupport::TestCase
  should validate_presence_of :name

  context "with a convention" do
    setup { FactoryGirl.create(:convention) } # required to validate_uniqueness

    should validate_uniqueness_of :name
  end

  should have_many(:linkables).through(:convention_linkables)
  should have_many :schedules

  should have_many :periods
  should have_many :auth_requirements

  should "create AuthRequirements at creation" do
    @convention = FactoryGirl.create(:convention)
    abilities = @convention.auth_requirements.collect{|ar| [ar.action, ar.model]}
    ars = [["read", "Convention"],["update", "Convention"],
           ["read", "Event"],["update", "Event"],["create", "Event"],["destroy", "Event"],
           ["read", "Space"],["update", "Space"],["create", "Space"],["destroy", "Space"],
           ["read", "Profile"],["update", "Profile"],["create", "Profile"],["destroy", "Profile"],
           ["read", "Job"],["update", "Job"],["create", "Job"],["destroy", "Job"]
          ]
    assert_equal ars, abilities
  end
end
