#----------------------------------------------------------------------------
# Basic production, development, and test gems
#----------------------------------------------------------------------------
path = "http://github.com/greenplastik/rails3-templates/raw/master"

run 'gem sources -a http://gems.github.com'
run 'gem install rails --pre'
run 'gem install bundler --pre'

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
source 'http://rubygems.org'
source 'http://gems.github.com'

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
  apply "#{path}/template-auth.rb"
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
  run 'gem install simple_form'
  gem 'simple_form'
  run 'rails generate simple_form:install'
end

if friendly_id
  run 'gem install friendly_id'
  gem "friendly_id", "~> 3.0"
  run 'rails generate friendly_id'
end

if nokogiri
  gem 'nokogiri', '>=1.4.1'
end

if rails3_generators
  run 'gem install rails3_generators'
  gem 'rails3_generators'
end

apply "#{path}/template-test.rb"