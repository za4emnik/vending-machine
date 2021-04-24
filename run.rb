require 'irb'
require 'bundler/setup'
require './lib/console'

Bundler.require(:default)

Lib::Console.new.run

IRB.start
