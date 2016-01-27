$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'barchart'
require 'webmock/rspec'
require 'rspec/its'
require 'rspec/collection_matchers'
require 'factory_girl'

RSpec.configure do |config|
  if ENV['CI']
    config.before(:example, :focus) { raise "Should not commit focused specs" }
  else
    config.filter_run focus: true
  end

  FactoryGirl.definition_file_paths = %w[./spec/factories]
  FactoryGirl.find_definitions

  config.run_all_when_everything_filtered = true
  config.include FactoryGirl::Syntax::Methods
  Dir[File.join(File.dirname(__FILE__), 'shared_examples', '*.rb')].each { |f| require f }
end
