require 'factory_girl'
require File.dirname(__FILE__) + '/../../test/factories.rb'
require 'yaml'

data = YAML::load(File.open("#{Rails.root}/db/seeds/example_data.yaml"))

puts "== Add Example Data =="

puts "Deleting existing data"
Convention.delete_all
Event.delete_all
Space.delete_all

puts "Creating example convention"
# Additional models for demonstration
anext = FactoryGirl.create :convention, name: 'AnimeNext 2010'
bcon = FactoryGirl.create :convention, name: 'Bureaucracon IV'

puts "Creating example events"
anext_events = data["anext"]["events"]
bcon_events = data["bcon"]["events"]

anext_events.each do |event|
  puts "- #{event["name"]}"
  e = FactoryGirl.create :event, name: event["name"], description: event["description"], conventions: [anext]
  e.create_time_span(:start_time => event["start"], :end_time => event["end"])
end

bcon_events.each do |event|
  FactoryGirl.create :event, name: event["name"], description: event["description"], conventions: [bcon]
end

puts "Creating example spaces"
anext_spaces = data["anext"]["spaces"]

anext_spaces.each do |id, space|
  s = Space.create(:name => space["name"], :parent_id => space["parent_id"])
  Space.connection.execute("UPDATE spaces SET id = #{id} WHERE id = #{s.id}")
  puts "- #{s.name}"
end

data["anext"]["rules"].each do |rule|
  case rule["type"]
    when "IsRelatedRule"
      event = Event.find_by_name(rule["event_name"])
      related_event = Event.find_by_name(rule["related_event_name"])
      #puts "#{event.name} #{related_event.name}"
      rule = IsRelatedRule.create(:related_event => related_event, :relation => rule["relation"])
      RuleAssignment.create(:event => event, :rule => rule)
  end
end