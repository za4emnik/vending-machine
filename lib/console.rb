require './database/adapter'
require './lib/vending_machine'
require './lib/validation'

module Lib
  class Console
    include Validation

    attr_reader :database, :machine

    def initialize
      @machine = VendingMachine.new
      @database = Database::Adapter.instance.adapter
    end

    def run
      show_products
      choose_product
    end

    private

    def show_products
      headings = ['Number of product', 'Name', 'Price', 'Quantity']
      title = 'There are the list of aviliable products:'
      rows = database.products.map(&:values)

      puts Terminal::Table.new title: title, headings: headings, rows: rows
    end

    def choose_product
      puts 'Type the number of product, please.'
      validate = validate_choose(@choosed_product = gets.chomp)

      raise validate if validate
    end
  end
end
