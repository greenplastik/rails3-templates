#----------------------------------------------------------------------------
# Template Roadmap
#----------------------------------------------------------------------------
path = "http://github.com/greenplastik/rails3-templates/raw/master"

require 'rails'

apply "#{path}/template-rvmrc.rb"
apply "#{path}/template-javascript.rb"
apply "#{path}/template-gems.rb"
apply "#{path}/template-smtp.rb"
apply "#{path}/template-finish.rb"