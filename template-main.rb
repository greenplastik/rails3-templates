require 'rails'
run 'gem install highline'
require 'highline/import'
@app_name = ask("What is the name of your app?") { |q| q.validate = /[a-zA-Z]/ }

@gemset = "rvm 1.9.2@#{@app_name}"
run "rvm use --create 1.9.2@#{@app_name}"

file '.rvmrc', <<-FILE
rvm 1.9.2@#{@app_name}
FILE

run "cd /#{@app_name}"

run "#{@gemset} gem install highline"

run 'rm public/javascripts/controls.js'
run 'rm public/javascripts/dragdrop.js'
run 'rm public/javascripts/effects.js'
run 'rm public/javascripts/prototype.js'

run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"
run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

run "#{@gemset} gem sources -a http://gems.github.com"
run "#{@gemset} install rails --pre"
run "#{@gemset} install bundler --pre"

require 'rails'
require 'bundler'
require 'highline/import'

auth = agree("Do you want to add authentication gems (devise/warden, cancan)?"){ |q| q.default = "Yes" }
rdiscount = agree("Do you want to add the rdiscount gem?"){ |q| q.default = "Yes" }
gravatar = agree("Do you want to add the gravatar gem?"){ |q| q.default = "Yes" }
linguistics = agree("Do you want to add the linguistics gems?"){ |q| q.default = "Yes" }
chronic = agree("Do you want to add the chronic gems?"){ |q| q.default = "Yes" }
simple_form = agree("Do you want to add the simple form gem?"){ |q| q.default = "Yes" }
friendly_id = agree("Do you want to add the friendly_id gem?"){ |q| q.default = "Yes" }
nokogiri = agree("Do you want to add the nokogiri gem?"){ |q| q.default = "Yes" }
rails3_generators = agree("Do you want to use the rails3_generators gem?"){ |q| q.default = "Yes" }

run 'rm Gemfile'
file 'Gemfile', <<-FILE
source :gemcutter
source 'http://gems.github.com'
source 'http://gems.rubyforge.org'

gem 'rails', '3.0.0.beta4'
gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

group :development do
  gem 'nifty-generators'
  gem 'wirble'
  gem 'yaml_db'
end

FILE

if auth
  devise_model = ask("\n\r\n\rWhat do you want to call your user model?\n\r\n\rExample: User. Press Enter to select the default (User):") { |q| q.validate = /[a-zA-Z]/ }

  if devise_model.blank? 
    devise_model = "User"
  else 
    devise_model = devise_model.humanize
  end

  run "#{@gemset} gem install cancan devise warden"
  gem 'cancan'
  gem 'devise', '>=1.1.rc2'
  gem 'warden'
  run 'rails generate devise:install'
  run 'rails generate devise:views'
  run "rails generate devise:#{devise_model}"
end

if rdiscount
  gem 'rdiscount'
end

if gravatar
  gem 'gravatar_image_tag'
end

if linguistics
  gem 'linguistics'
end

if chronic
  gem 'robballou-chronic'
end

if simple_form
  run "#{@gemset} gem install simple_form"
  gem 'simple_form'
  run 'rails generate simple_form:install'
end

if friendly_id
  run "#{@gemset} gem install friendly_id"
  gem "friendly_id", "~> 3.0"
  run 'rails generate friendly_id'
end

if nokogiri
  gem 'nokogiri', '>=1.4.1'
end

if rails3_generators
  run "#{@gemset} gem install rails3_generators"
  gem 'rails3_generators'
end

rspec = agree("Do you want to add use rspec for testing?"){ |q| q.default = "Yes" }
cucumber = agree("Do you want to add use cucumber for testing?"){ |q| q.default = "Yes" }
factory_girl = agree("Do you want to add use factory_girl for testing?"){ |q| q.default = "Yes" }
mocha = agree("Do you want to add use mocha for testing?"){ |q| q.default = "Yes" }
shoulda = agree("Do you want to add use shoulda for testing?"){ |q| q.default = "Yes" }

if rspec
  run "#{@gemset} gem install rspec-rails --pre"
  gem 'rspec', '>= 2.0.0.beta.17', :group => :test
  gem 'rspec-rails', '>= 2.0.0.beta.17', :group => :test
  run 'rails generate rspec:install'
end

if cucumber
  run "#{@gemset} gem install capybara database_cleaner cucumber cucumber-rails rspec_rails spork launchy"

  gem 'capybara', :group => :test
  gem 'database_cleaner', :group => :test
  gem 'cucumber', :group => :test
  gem 'cucumber-rails', :group => :test
  gem 'rspec-rails', :group => :test
  gem 'spork', :group => :test
  gem 'launchy', :group => :test

  run 'rails generate cucumber:install --rspec --capybara'
end

if factory_girl
  run "#{@gemset} gem install factory_girl"
  gem 'factory_girl', :group => :test
end

if rspec && factory_girl
  application  <<-GENERATORS 
  config.generators do |g|
    g.test_framework  :rspec, :fixture => true, :views => false
    g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
  end
  GENERATORS
end

mailer_name = ask("\r\n\r\nWhat do you want to call your mailer?\n\r\n\rEnter the mailer name without any file extension (Default: mailer):")
mailer_name ||= "mailer"

address = ask("\n\r\n\rWhat is your smtp server?\n\r\n\rExample: smtp.gmail.com. Press Enter to select the default (smtp.gmail.com):")
address ||= "smtp.gmail.com"


domain = ask("\r\n\r\nWhat is your email domain?\n\r\n\rExample: www.gmail.com. Press Enter to select the default (www.gmail.com):")
domain ||= "www.gmail.com"

user_name = ask("\r\n\r\nWhat is your email user name?\n\r\n\r(Enter your username with the domain):")
password = ask("\r\n\r\nWhat is your email password?")

# Generate mailer
run "rails generate mailer #{mailer_name}"

# Generate mailer settings initializer
initializer "#{mailer_name}.rb", <<-FILE
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address              => '#{address}',
  :port                 => 587,
  :domain               => '#{domain}',
  :user_name            => '#{user_name}',
  :password             => '#{password}',
  :authentication       => "plain",
  :enable_starttls_auto => true
}
FILE

run 'bundle install'
run 'rails generate nifty:config'
run 'rails generate nifty:layout'

run 'rake db:migrate'

if agree("Add welcome screen ?"){ |q| q.default = "Yes" }
  run "rails generate nifty:scaffold Welcome show"
  route "root :to => 'welcome#show'" 
end

run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/images/rails.png'
run 'rm .gitignore'
run 'touch README'
run "echo 'TODO add readme content' > README"

file '.gitignore', <<-FILE
.bundle
.DS_Store
.rvmrc

*.tmproj
*.sw?
*.gems

db/*.db
db/*.sqlite3
doc/*.dot
doc/api
doc/app
doc/plugins

capybara-*
config/database.yml
coverage/*
coverage.*

gems/*

log/*.log
log/*.pid

rerun.txt

tmp/**/*

!gems/cache
!gems/bundler
!public/flash/clippy.swf
FILE

git :init
git :submodule => "init"
git :add => '.'
git :commit => "-a -m 'Initial commit'"

puts 'Success! Enjoy your shiny new app!'
run "cd /#{@app_name}"