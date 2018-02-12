require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "foreigner"

RSpec::Core::RakeTask.new(:spec)

desc "Task to fetch rates from the European Central Bank.
      The task downloads and stores the rates as a JSON file
      in ./sources/rates.json. The output is stored in a format
      that can be read by the main exchange rate library."
task :fetch_ecb_rates, [:url] do |t, args|
  logger = Logger.new(STDOUT)
  logger.info("Fetching rates from ECB")
  ecb = Foreigner::Sources::ECB.new(url: args[:url])
  ecb.fetch_rates
  logger.info("Rates fetched successfully from ECB")
end
