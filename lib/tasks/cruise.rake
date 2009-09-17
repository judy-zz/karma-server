namespace :gems do
  task :use_sudo do
    class Rails::GemDependency
      # use sudo when running the "gem" command.
      def gem_command
        'sudo gem'
      end
    end
  end
end
  
desc 'Custom sequence for cruise control to test the application'
task :cruise => ['gems:use_sudo', 'gems:install', 'db:migrate', 'spec', 'cucumber'] do 
end
