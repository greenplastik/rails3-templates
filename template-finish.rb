require 'highline/import'

run 'bundle install'
run 'rails generate nifty:config'
run 'rails generate nifty:layout'

run 'rake db:migrate'

if agree("Add welcome screen ?"){ |q| q.default = "Yes" }
  run "rails generate nifty:scaffold Welcome show"
  route "root :to => 'welcome#show'"
end

apply "http://github.com/greenplastik/rails3-templates/raw/master/template-git.rb"

puts 'Success! Enjoy your shiny new app!'