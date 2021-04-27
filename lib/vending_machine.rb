require './database/adapter'
require './lib/validation'

module Lib
  class VendingMachine
    include Validation

    attr_reader :database, :balance

    def initialize
      @database = Database::Adapter.instance.adapter
      @balance = 0.0
      initialize_rest
    end

    def select_product(product_id)
      select_product = database.find_product(product_id)
      validate_selected_product(select_product)

      @product_id = product_id
    end

    def add_coin(coin)
      validate_coin(coin)

      @balance += coin.to_f
      database.add_coin(coin)
    end

    def buy
      validate_purchase(balance, product)

      database.decrease_product_quantity(product)
      @balance -= product[:price]
      product
    end

    def odd_money
      calculate_rest
      remove_selected_product
      old_rest = @rest
      initialize_rest

      old_rest
    end

    def product
      database.find_product(product_id)
    end

    private

    attr_reader :product_id

    def remove_selected_product
      @product_id = nil
    end

    def calculate_rest
      @balance = @rest.reduce(balance) do |acc, (coin, _amount)|
        coins_count = (acc / coin).to_i
        next acc unless coins_count.positive?

        throw_coins(coins_count, coin, acc)
      end
    end

    def throw_coins(coins_count, coin, acc)
      funds = database.funds

      coins_count.times do
        break unless funds[coin].positive?

        database.drop_coin(coin)
        @rest[coin] += 1
        acc -= coin
      end

      acc
    end

    def initialize_rest
      @rest = Validation::ALLOWED_COINS.sort.reverse.map { |coin| { coin => 0 } }.inject(:merge)
    end
  end
end
