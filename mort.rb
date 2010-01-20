#MongOdb Rails Template

#based on the initial gist from bscofield: http://gist.github.com/181842
#also inspired by Mike Gunderloy's Big Old Rails Template: http://github.com/ffmike/BigOldRailsTemplate

# remove unneeded defaults
run "rm public/index.html"
run "rm public/images/rails.png"
run "rm public/javascripts/controls.js"
run "rm public/javascripts/dragdrop.js"
run "rm public/javascripts/effects.js"
run "rm public/javascripts/prototype.js"

# add basic layout to start
file 'app/views/layouts/application.html.erb', <<-ERB
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <title>Application!</title>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" type="text/javascript"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js" type="text/javascript"></script>
  <%= stylesheet_link_tag '960' 'reset' 'text' 'global'%>
</head>
<body>
  <%= yield %>
</body>
</html>
ERB

db_name = ask('What should I call the database? ')

initializer 'database.rb', <<-CODE
MongoMapper.database = "#{db_name}-\#{Rails.env}"
CODE

file 'config/database.yml', <<-CODE
# Using MongoDB
CODE

environment 'config.frameworks -= [:active_record]'

gem 'mongomapper'
gem 'redgreen'
gem "haml"
gem 'thoughtbot-shoulda', :lib => 'shoulda/rails', :source => 'http://gems.github.com'
gem "jeremymcanally-matchy", :lib => "matchy", :source => "http://gems.github.com"

# Gem management
rake 'gems:unpack'
rake 'rails:freeze:gems'


plugin 'high_voltage', :git => 'git://github.com/thoughtbot/high_voltage.git'

# source control
file '.gitignore', <<-FILES
.DS_Store
**/.DS_Store
log/*
tmp/*
tmp/**/*
config/database.yml
coverage/*
coverage/**/*
FILES

git :init
git :add => '.'
git :commit => '-a -m "Initial commit"'
