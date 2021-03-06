include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :event do
    sequence(:name) {|n| "Event #{n}"}
    description 'Description'
  end

  factory :tag_group do
    sequence(:name) {|n| "Tag Group #{n}"}
    description 'Tag group description'
  end

  factory :tag do
    sequence(:name) {|n| "Tag #{n}"}
  end

  factory :convention do
    sequence(:name) {|n| "Convention #{n}"}
    description 'Convention description'
  end

  factory :space do
    sequence(:name) {|n| "Space #{n}"}
    sequence(:venue_designated_name) {|n| "Designated Venue Name #{n}"}
    space_type 'area'
  end

  factory :time_span do
    start_time Time.parse("Jan 1 2011")
    end_time Time.parse("Jan 5 2011")
    confidence 0
  end

  factory :reservation do
    association :reservee, factory: :event
    association :reservable, :factory => :space
    inherit_time_span true
  end

  factory :admin_user, :class => :user do
    sequence(:email) {|n| "user#{n}@fakemail.net"}
    sequence(:username) {|n| "user#{n}"}
    password 'password'
    password_confirmation 'password'
    admin true
  end

  factory :user do
    sequence(:email) {|n| "user#{n}@fakemail.net"}
    sequence(:username) {|n| "user#{n}"}
    password 'password'
    password_confirmation 'password'
  end

  factory :profile do
    sequence(:name) {|n| "Profile #{n}"}
  end

  factory :job do
    sequence(:name) {|n| "Job #{n}"}
  end

  factory :phone do
    number "555-555-5555"
    phone_type "mobile"
  end

  factory :schedule do
    sequence(:name) {|n| "Schedule #{n}"}
    association :convention
    association :time_span
  end

  factory :role do
    name "Test Dept Staff"
    department "Test Dept"
    association :convention
    association :profile
  end

  factory :period do
    name "Test Period"
    association :time_span
    association :convention
  end

  factory :map do
    association :space
    image { fixture_file_upload(Rails.root.to_s+'/test/fixtures/test.png', 'image/png') }
  end

  factory :address do
    text "612 Wharf Avenue, Red Bank, NJ"
  end
end