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