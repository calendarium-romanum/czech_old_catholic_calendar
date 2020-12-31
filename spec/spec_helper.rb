require "bundler/setup"
require "czech_old_catholic_calendar"

require 'calendarium-romanum/cr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Czech Old Catholic Church calendar is usually not needed in any other language
I18n.locale = :cs
