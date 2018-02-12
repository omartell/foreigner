require "bundler/setup"
require "foreigner"
require "webmock/rspec"


Foreigner.configure do |config|
  config.rates_store = "/tmp/rates.json"
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.around(:each) do |example|
    File.delete(Foreigner::Config.rates_store) if File.exist?(Foreigner::Config.rates_store)

    example.run
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
