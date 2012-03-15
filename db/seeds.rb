# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
require File.dirname(__FILE__) + '/../test/factories.rb'

Con.delete_all
Event.delete_all
Tagging.delete_all
Tagging.delete_all
TagGroup.delete_all

# Core data required for the app
Factory :tag_group, name: 'Conventions', description: 'Automatically generated list of all conventions in the database'

# Additional models for demonstration
Factory :con, name: 'AnimeNext 2010'

events = [
  {name: 'BlazBlue & King of Fighters 2002 Ultimate Match'},
  {name: 'Tatsunoki vs. Capcom & Vampire Savior'},
  {name: 'Dealers Room Friday'},
  {name: 'Manga Library Friday'},
  {name: 'Art Show'},
  {name: 'Masquerade Rehearsal Part 1'},
  {name: 'Launch Party'},
  {name: 'Kenji Kamiyama'},
  {name: 'Concert Seating'},
  {name: 'Stereopony Concert'},
  {name: 'Uncle Yo'},
  {name: 'Cosplay Burlesque'},
  {name: 'AMV Screening'},
  {name: 'Kenji Kamiyama Autograph Session'},
  {name: 'Anime Parliament'},
  {name: 'Stereopony Green Room'},
  {name: 'Sleeping Samurai'},
  {name: 'Big Bald Broadcast'},
  {name: 'Crossplay for Girls'},
  {name: 'Baron Munchausen - Charity Drive'},
  {name: 'Hetalia: 2010 World Summit'},
  {name: 'Robotech: Goes to the Movies'},
  {name: 'Greg Ayres: From Host Club to Hospital'},
  {name: 'These are a Few of my Favorite Scenes'}
]

events.each do |event|
  Factory :event, name: event[:name], description: event[:description]
end