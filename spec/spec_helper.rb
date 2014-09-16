require 'coveralls'
Coveralls.wear!
require 'faker'
require 'rspec/collection_matchers'
require 'factory_girl'
require_relative '../lib/iml_logistics_api'

Dir[File.join(File.dirname(__FILE__), "/factories/**/*.rb")].each {|f| require f; puts f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
end

