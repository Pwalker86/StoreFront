ENV["RAILS_ENV"] ||= "test"
require "simplecov"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"

SimpleCov.start "rails"

unless ENV["RM_INFO"]
  reporter_options = { color: true }
  # Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(reporter_options)]
  Minitest::Reporters.use! [ Minitest::Reporters::DefaultReporter.new(reporter_options) ]
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
