RSpec.configure do |config|
  config.before do
    Config.load_and_set_settings('config/settings.yml')
  end
end
