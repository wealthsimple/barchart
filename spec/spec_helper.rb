$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'barchart'
require 'webmock/rspec'
require 'rspec/its'
require 'rspec/collection_matchers'
Dir[File.join(File.dirname(__FILE__), 'shared_examples', '*.rb')].each { |f| require f }

# Test configuration
Barchart.configure do |config|
  config.api_base_url = "http://api_base_url"
  config.api_key = "secret"
end
Barchart.logger = Logger.new(nil)

RSpec.configure do |config|
  if ENV['CI']
    config.before(:example, :focus) { raise "Should not commit focused specs" }
  else
    config.filter_run focus: true
  end

  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def fixture(filename)
  File.read("./spec/fixtures/#{filename}")
end
