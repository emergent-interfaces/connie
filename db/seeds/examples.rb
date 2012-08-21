#require './factory_girl'
#require File.dirname(__FILE__) + '/../../test/factories.rb'
require 'yaml'
require 'open-uri'

puts "== Add Example Data =="
puts "Deleting existing data"
Convention.delete_all
AuthRequirement.delete_all
Event.delete_all
Space.delete_all
Map.delete_all
Reservation.delete_all
TimeSpan.delete_all
ConventionLinkable.delete_all
BeScheduledRule.delete_all
IsRelatedRule.delete_all
DurationRule.delete_all
RuleAssignment.delete_all
Schedule.delete_all
ScheduleReservable.delete_all
Profile.delete_all
Role.delete_all

def find_reservable_by_name(name)
  reservable = Space.find_by_name(name)
  reservable = Profile.find_by_name(name) unless reservable
  reservable
end

def load_convention(file_name)
  data = YAML::load(File.open(file_name))

  puts "Creating example convention"
  convention = Convention.create(:name => data["convention"]["name"])
  puts "- #{convention.name}"

  if data["convention"]["auth_requirements"]
    puts "Setting AuthRequirements"
    data["convention"]["auth_requirements"].each do |auth_req|
      ar = convention.auth_requirements.find_by_model_and_action(auth_req["model"],auth_req["action"])
      ar.requirement = auth_req["requirement"]
      ar.save!
      puts "- #{ar.model}, #{ar.action}, #{ar.requirement}"
    end
  end

  convention_profiles = data["profiles"]
  if convention_profiles
    puts "Creating example profiles"

    convention_profiles.each do |profile|
      p = convention.profiles.create(:name => profile["name"])
      role_data = profile["role"].split(":")
      p.roles.create(:department => role_data[0], :name => role_data[1], :convention => convention)
      puts "- #{p.name}, #{p.roles[0].department}:#{p.roles[0].name}"
    end
  end

  convention_spaces = data["spaces"]
  if convention_spaces
    puts "Creating example spaces"

    convention_spaces.each do |space|
      s = Space.create!(:name => space["name"],
                        :venue_designated_name => space["venue_designated_name"],
                        :parent => Space.find_by_name(space["parent"]),
                        :space_type => space["space_type"],
                        :conventions => [convention])


      m = s.maps.create!(:image => open("db/seeds/images/"+space["map_image"])) if space["map_image"]

      if space["address"]
        s.create_own_address!(:text => space["address"])
        s.inherit_address = false
        s.save
      end

      puts "- #{s.name}"
    end
  end

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

      if event["reserves"]
        e.reservations.create!(:reservable => find_reservable_by_name(event["reserves"]), :inherit_time_span => true)
      end
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

  convention_schedules = data["schedules"]
  if convention_schedules
    puts "Creating example schedules"

    data["schedules"].each do |schedule_data|
      start_time = DateTime.parse("#{schedule_data["start"]} EST")
      end_time = DateTime.parse("#{schedule_data["end"]} EST")

      schedule = convention.schedules.create(:name => schedule_data["name"], :time_span_attributes => {
          :start_time => start_time,
          :end_time => end_time,
          :confidence => 0
      })

      schedule_data["reservables"].each do |reservable_name|
        reservable = find_reservable_by_name(reservable_name)

        schedule.schedule_reservables.create!(:reservable => reservable)
      end

      puts "- #{schedule.name} in #{schedule.convention.name}"
    end
  end
end

load_convention("#{Rails.root}/db/seeds/anext_data.yaml")
load_convention("#{Rails.root}/db/seeds/bcon_data.yaml")






