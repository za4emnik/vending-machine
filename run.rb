require 'irb'
require 'bundler/setup'
require './lib/console'
require 'pry'

Bundler.require(:default)
Config.load_and_set_settings('config/settings.yml')

Lib::Console.new.run

IRB.start
