require 'factory_girl'
require File.dirname(__FILE__) + '/../../test/factories.rb'

puts "== Setup Core Models =="

puts "Deleting existing data"
Convention.delete_all
Event.delete_all
Tagging.delete_all
Tagging.delete_all
TagGroup.delete_all

puts "Creating core tags"
# Core data required for the app
Factory :tag_group, name: 'Conventions', description: 'Automatically generated list of all conventions in the database'