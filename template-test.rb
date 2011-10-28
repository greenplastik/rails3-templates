require 'highline/import'

rspec = agree("Do you want to add use rspec for testing?"){ |q| q.default = "Yes" }
cucumber = agree("Do you want to add use cucumber for testing?"){ |q| q.default = "Yes" }
factory_girl = agree("Do you want to add use factory_girl for testing?"){ |q| q.default = "Yes" }
mocha = agree("Do you want to add use mocha for testing?"){ |q| q.default = "Yes" }
shoulda = agree("Do you want to add use shoulda for testing?"){ |q| q.default = "Yes" }
path = "http://github.com/greenplastik/rails3-templates/raw/master"

if rspec
  apply "#{path}/template-rspec.rb"
end

if rspec
  apply "#{path}/template-rspec.rb"
end

if cucumber
  apply "#{path}/template-cucumber.rb"
end

if factory_girl
  apply "#{path}/template-factory_girl.rb"
end

if rspec && factory_girl
  application  <<-GENERATORS
  config.generators do |g|
    g.test_framework  :rspec, :fixture => true, :views => false
    g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
  end
  GENERATORS
end