Connie
======
An open-source web application for managing large conventions using rules based design.

Development
-----------
Use `rake db:seed` to populate the development database with core data required by the
application as well as some example data which makes the site interesting to browse.  These
operations can be performed separately via `rake db:seed:core` and `rake db:seed:examples`.

When you are setting up the test environment after a migration, you will want to seed only
the core models.  Then, run `db:test:clone` to mirror the dev database into the test environment.
You should then seed the examples into the dev database.  Or not, but it's your loss.

To use/test with search functionality run `rake sunspot:solr:run` on the development and/or
test environment.  If you don't do this you will see connection refused errors.  There is a helper
in the repository root for setting up a screen instance on a linux system.  Run `./rails-dev-screen.sh`
to start up screen with webrick, Solr for dev, and Solr for test.