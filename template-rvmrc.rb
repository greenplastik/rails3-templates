#----------------------------------------------------------------------------
# .rvmrc setup
#----------------------------------------------------------------------------

app_name = ask("What is the name of your app?") { |q| q.validate = /[a-zA-Z]/ }

# ruby=ask("\r\n\r\nWhich version of Ruby do you want to use?\n\r\n\rMake sure to choose one of your installed"){ |q| q.default = "mailer" }
# 
# noncompete = choose do |menu|
#   menu.prompt = "\r\n\r\nWhich version of Ruby do you want to use?\n\r\n\rMake sure to choose one of your installed"
#   menu.choices("#{party_a}", "#{party_b}", "Both", "Neither")
# end
# 
# gemset=
# 
# file '.rvmrc', <<-FILE
# rvm use --create '#{ruby}'@'#{gemset}'
# FILE

run "rvm use --create 1.9.2@#{app_name}"
run "rvm 1.9.2@#{app_name}"

file '.rvmrc', <<-FILE
rvm 1.9.2@#{app_name}
FILE

run 'gem install highline'