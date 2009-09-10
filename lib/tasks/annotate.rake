namespace :db do
  desc "Annotate models."
  task :annotate do
    system 'annotate'
  end
end