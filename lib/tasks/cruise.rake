desc 'Custom sequence for cruise control to test the application'
task :cruise => ['gems:install', 'db:migrate', :spec, :cucumber] do 
end
