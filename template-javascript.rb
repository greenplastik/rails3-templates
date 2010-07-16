#----------------------------------------------------------------------------
# JQuery Setup
#----------------------------------------------------------------------------
run 'rm public/javascripts/controls.js'
run 'rm public/javascripts/dragdrop.js'
run 'rm public/javascripts/effects.js'
run 'rm public/javascripts/prototype.js'

run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"
run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"
