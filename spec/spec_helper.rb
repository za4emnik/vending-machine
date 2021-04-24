require 'bundler/setup'
Bundler.require(:test)

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
