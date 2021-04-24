require './database/yaml'
require './lib/vending_machine'

module Lib
  class Console
    attr_reader :database

    def initialize
      @machine = VendingMachine.new
      @database = Database::Yaml.new
    end

    def run
      show_products
    end

    def show_products
      puts 'There are the list of aviliable products:'

      database.products.each do |product|
        puts product[:id]
        puts product[:name]
        puts product[:price]
        puts product[:count]
      end
    end
  end
end
