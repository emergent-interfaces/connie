#require './factory_girl'
#require File.dirname(__FILE__) + '/../../test/factories.rb'
require 'yaml'

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

def load_convention(file_name)
  data = YAML::load(File.open(file_name))

  puts "Creating example convention"
  # convention = FactoryGirl.create :convention, name: data["convention"]["name"]
  convention = Convention.create(:name => data["convention"]["name"])
  puts "- #{convention.name}"

  convention_events = data["events"]
  if convention_events
    puts "Creating example events"

    convention_events.each do |event|
      puts "- #{event["name"]}"
      e = Event.create name: event["name"], description: event["description"], conventions: [convention]
      if event["start"] and event["end"]
        start_time = DateTime.parse("#{event["start"]} EST")
        end_time = DateTime.parse("#{event["end"]} EST")
        e.create_time_span(:start_time => start_time, :end_time => end_time, :confidence => 2)
      end
    end
  end

  convention_spaces = data["spaces"]
  if convention_spaces
    puts "Creating example spaces"

    convention_spaces.each do |space|
      s = Space.create!(:name => space["name"],
                        :parent => Space.find_by_name(space["parent"]),
                        :space_type => space["space_type"],
                        :conventions => [convention])
      puts "- #{s.name}"
    end
  end


  convention_reservations = data["reservations"]
  if convention_reservations
    puts "Creating example reservations"

    data["reservations"].each do |reservation|
      e = Event.find_by_name(reservation["event"])
      reservable_class = reservation["reservable_type"].constantize
      reservable = reservation["reservable"]
      r = e.reservations.create(:reservable => reservable_class.find_by_name(reservable),
                                :inherit_time_span => true)

      puts "- #{e.name} reserves #{r.reservable.name}"
    end
  end


  convention_rules = data["rules"]
  if convention_rules
    puts "Creating example rules"

    data["rules"].each do |rule|
      case rule["type"]
        when "IsRelatedRule"
          event = Event.find_by_name(rule["event"])
          related_event = Event.find_by_name(rule["related_event"])
          rule = IsRelatedRule.create(:related_event => related_event, :relation => rule["relation"])
          RuleAssignment.create(:event => event, :rule => rule)

          puts "- #{event.name} #{rule["relation"]} #{related_event.name}"
      end
    end
  end
end

load_convention("#{Rails.root}/db/seeds/anext_data.yaml")
load_convention("#{Rails.root}/db/seeds/bcon_data.yaml")






