An example application that demonstrates:

* ActiveRecord basics, see: app/models
* Converting objects to simple data, see: lib/ard.rb
* ActionController basics, see: app/controllers
* API specific controllers, see: app/controllers/api
* Server-rendered UI with mustache, see the server method in: app/controllers/api
* Client-rendered UI (using API enpoints) with backbone and mustache, see: app/assets/javascripts
* Server-side presenter pattern, see: app/helpers/ui_presenter
* Client-side presenter pattern, see: app/assets/javascripts/presenters.js

Some interactions are still missing! Pull requests welcome! Help us make this better

---

Setup & run with:

    bundle
    bundle exec rake db:create db:seed
    bundle exec rails s

The server-rendered UI is at: http://localhost:3000/server

The client (backbone) UI is at: http://localhost:3000/client
