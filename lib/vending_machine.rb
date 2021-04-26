require './database/adapter'
require './lib/validation'

module Lib
  class VendingMachine
    include Validation

    FUNDS = {
      0.25 => 0,
      0.5 => 0,
      1.0 => 0,
      2.0 => 0,
      3.0 => 0,
      5.0 => 0
    }.freeze

    attr_accessor :product_id
    attr_reader :rest, :database

    def initialize
      @database = Database::Adapter.instance.adapter
      @funds = FUNDS.dup
    end
    
    def add_funds(coin)
      validate_coin(coin)

      @funds[coin.to_f] += 1
      database.add_coin(coin)
    end

    def funds
      @funds.inject(&:+)
    end
    
    def rest
      1
    end

    private

    def enough_funds?
      @validation.validate_amount(money, product)
    end

    # def decrease_product_quantity
    #   database.decrease_product_quantity(product)
    # end

    def product
      @product ||= database.find_product(product_id.to_i)
    end
  end
end
