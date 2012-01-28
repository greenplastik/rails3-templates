require 'highline/import'
require 'rails'

devise_model = ask("\n\r\n\rWhat do you want to call your user model?\n\r\n\rExample: User. Press Enter to select the default (User):") { |q| q.validate = /[a-zA-Z]/ }

if devise_model.blank?
  devise_model = "User"
else
  devise_model = devise_model.titleize
end

run 'gem install cancan devise warden'
gem 'cancan'
gem 'devise', '>=1.1.rc2'
gem 'warden'
run 'rails generate devise:install'
run 'rails generate devise:views'
run "rails generate devise:#{devise_model}"