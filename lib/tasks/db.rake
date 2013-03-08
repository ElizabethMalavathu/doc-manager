namespace :db do 
  desc "reset whole db"
  task :hard_reset => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
end
