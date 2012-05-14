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
  end

  factory :time_span do
    start_time Time.parse("Jan 1 2011")
    end_time Time.parse("Jan 5 2011")
    confidence 0
  end

  factory :reservation do
    association :event
    association :reservable, :factory => :space
  end

  factory :user do
    sequence(:email) {|n| "user#{n}@fakemail.net"}
    password 'password'
    password_confirmation 'password'
  end
end