require 'factory_girl'
require File.dirname(__FILE__) + '/../../test/factories.rb'

Rake::Task["tmp:sessions:clear"].execute
puts "Remember to reset your cookies to clear the session"

puts "== Setup Core Models =="

puts "Deleting existing data"
Convention.delete_all
Event.delete_all
Tagging.delete_all
Tagging.delete_all
TagGroup.delete_all
Space.delete_all

puts "Creating core maps"

puts "Creating core tags"
# Core data required for the app
FactoryGirl.create :tag_group, name: 'Conventions', description: 'Automatically generated list of all conventions in the database'