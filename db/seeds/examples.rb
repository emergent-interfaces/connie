require 'factory_girl'
require File.dirname(__FILE__) + '/../../test/factories.rb'
require 'yaml'

data = YAML::load(File.open("#{Rails.root}/db/seeds/example_data.yaml"))

puts "== Add Example Data =="

puts "Deleting existing data"
Convention.delete_all
Event.delete_all
Space.delete_all
Reservation.delete_all
TimeSpan.delete_all

ConventionLinkable.delete_all

BeScheduledRule.delete_all
IsRelatedRule.delete_all
DurationRule.delete_all
RuleAssignment.delete_all

puts "Creating example convention"
# Additional models for demonstration
anext = FactoryGirl.create :convention, name: 'AnimeNext 2010'
bcon = FactoryGirl.create :convention, name: 'Bureaucracon IV'

puts "Creating example events"
anext_events = data["anext"]["events"]
bcon_events = data["bcon"]["events"]

anext_events.each do |id, event|
  puts "- #{event["name"]}"
  e = Event.create name: event["name"], description: event["description"]
  Event.connection.execute("UPDATE events SET id = #{id} WHERE id = #{e.id}")
  e = Event.find(id)
  e.conventions << anext
  e.save
  start_time = DateTime.parse("#{event["start"]} EST")
  end_time = DateTime.parse("#{event["end"]} EST")
  e.create_time_span(:start_time => start_time, :end_time => end_time, :confidence => 2)
end

bcon_events.each do |event|
  FactoryGirl.create :event, name: event["name"], description: event["description"], conventions: [bcon]
end

puts "Creating example spaces"
anext_spaces = data["anext"]["spaces"]

anext_spaces.each do |id, space|
  s = Space.create!(:name => space["name"], :parent_id => space["parent_id"], :space_type => space["space_type"])
  Space.connection.execute("UPDATE spaces SET id = #{id} WHERE id = #{s.id}")
  puts "- #{s.name}"
end

puts "Creating example reservations"
anext_reservations = data["anext"]["reservations"]

anext_reservations.each do |reservation|
  e = Event.find(reservation["event"])
  reservable_class = reservation["reservable_type"].constantize
  reservable_id = reservation["reservable_id"]
  r = e.reservations.create(:reservable => reservable_class.find(reservable_id))

  puts "- #{e.name} reserves #{r.reservable.name}"
end

puts "Creating example rules"

data["anext"]["rules"].each do |rule|
  case rule["type"]
    when "IsRelatedRule"
      event = Event.find(rule["event_id"])
      related_event = Event.find(rule["related_event_id"])
      rule = IsRelatedRule.create(:related_event => related_event, :relation => rule["relation"])
      RuleAssignment.create(:event => event, :rule => rule)

      puts "- #{event.name} #{rule["relation"]} #{related_event.name}"
  end
end