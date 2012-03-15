Factory.define :event do |f|
  f.sequence(:name) {|n| "Event #{n}"}
  f.description 'Description'
end

Factory.define :tag_group do |f|
  f.sequence(:name) {|n| "Tag Group #{n}"}
  f.description 'Tag group description'
end

Factory.define :con do |f|
  f.sequence(:name) {|n| "Convention #{n}"}
  f.description 'Convention description'
end