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