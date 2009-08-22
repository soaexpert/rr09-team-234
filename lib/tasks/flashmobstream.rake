namespace:flashmobstream do
  desc "Redefine the environment"
  task:reset => :environment do
    Rake::Task["db:migrate:reset"].invoke
    Rake::Task["db:fixtures:load"].invoke
  end
end
