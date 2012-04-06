require 'factory_girl'
require File.dirname(__FILE__) + '/../../test/factories.rb'

puts "== Add Example Data =="

puts "Creating example convention"
# Additional models for demonstration
anext = FactoryGirl.create :convention, name: 'AnimeNext 2010'
bcon = FactoryGirl.create :convention, name: 'Bureaucracon IV'

puts "Creating example events"
anext_events = [
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

bcon_events = [
  {name: 'Legal-size Paper Distribution'},
  {name: 'On the Influence of #3 Pencils'},
  {name: 'Pre-registration'},
  {name: 'Post-pre-registration Presentation'},
  {name: 'Committee for Formation of Committees Meeting'},
]

anext_events.each do |event|
  FactoryGirl.create :event, name: event[:name], description: event[:description], conventions: [anext]
end

bcon_events.each do |event|
  FactoryGirl.create :event, name: event[:name], description: event[:description], conventions: [bcon]
end