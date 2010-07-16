run 'gem install capybara database_cleaner cucumber cucumber-rails rspec_rails spork launchy'

gem 'capybara', :group => :test
gem 'database_cleaner', :group => :test
gem 'cucumber', :group => :test
gem 'cucumber-rails', :group => :test
gem 'rspec-rails', :group => :test
gem 'spork', :group => :test
gem 'launchy', :group => :test

run 'rails generate cucumber:install --rspec --capybara'