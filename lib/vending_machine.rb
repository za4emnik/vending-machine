require './database/adapter'
require './lib/validation'

module Lib
  class VendingMachine
    ALLOWED_COINS = [0.25, 0.5, 1, 2, 3, 5].freeze

    attr_accessor :product_id, :customer_money
    attr_reader :database, :errors

    def initialize
      @database = Database::Adapter.instance.adapter
      @validation = Lib::Validation.new
    end

    def buy
      return false unless enough_funds?

      decrease_product_quantity
      true
    end

    def odd_money; end

    private

    def enough_funds?
      @validation.validate_amount(money, product)
    end

    def decrease_product_quantity
      database.decrease_product_quantity(product)
    end

    def product
      @product ||= database.find_product(product_id.to_i)
    end
  end
end
