Factory.define :event do |f|
  f.sequence(:name) {|n| "Event #{n}"}
  f.description 'Description'
end

Factory.define :tag_group do |f|
  f.sequence(:name) {|n| "Tag Group #{n}"}
  f.description 'Tag group description'
end

Factory.define :tag do |f|
  f.sequence(:name) {|n| "Tag #{n}"}
end

Factory.define :convention do |f|
  f.sequence(:name) {|n| "Convention #{n}"}
  f.description 'Convention description'
end

Factory.define :space do |f|
  f.sequence(:name) {|n| "Space #{n}"}
  f.sequence(:venue_designated_name) {|n| "Designated Venue Name #{n}"}
end