# Create a custom task for cruise control that migrates the database and runs
# our specs and stories.
task :cruise => ['gems:install', 'db:migrate', :spec, :features] do 
end
