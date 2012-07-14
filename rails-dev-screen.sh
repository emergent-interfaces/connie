screen -dmS rails-dev
screen -S rails-dev -p 0 -X title webrick
screen -S rails-dev -p 0 -X exec rails s
screen -S rails-dev -X screen
screen -S rails-dev -p 1 -X title solr-dev
screen -S rails-dev -p 1 -X exec rake sunspot:solr:run
screen -S rails-dev -X screen
screen -S rails-dev -p 2 -X title solr-test
screen -S rails-dev -p 2 -X exec rake sunspot:solr:run RAILS_ENV=test

screen -r
