#----------------------------------------------------------------------------
# SMTP Mailer Setup
#----------------------------------------------------------------------------
require 'highline/import'
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
