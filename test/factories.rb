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
end