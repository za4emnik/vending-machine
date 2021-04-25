require './database/adapter'

module Lib
  class VendingMachine
    ALLOWED_COINS = [0.25, 0.5, 1, 2, 3, 5].freeze

    attr_accessor :product_id, :money
    attr_reader :database, :errors

    def initialize
      @database = Database::Adapter.instance.adapter
      @validation = Lib::Validation.new
    end

    def pay
      charge
      return_product
    end

    private

    def charge
      validate_amount(money, product)
      update_product_quantity
    end

    # def choose_product
    #   puts 'Type the number of product, please.'
    #   validate = validate_choose(@choosed_product = gets.chomp)

    #   raise validate if validate
    # end

    def product
      @product =|| database.find_product(product_id.to_i)
    end

    def return_product; end
  end
end
