require './database/adapter'
require './lib/machine_error'

module Lib
  module Validation
    ALLOWED_COINS = [0.25, 0.5, 1.0, 2.0, 3.0, 5.0].freeze

    def validate_choose(product_id)
      raise Lib::MachineError.new('You can to type only number of the product.') if product_id.to_i.zero?
      raise Lib::MachineError.new('Selected product do not exist. Please, try again.') if product(product_id).empty?
    end

    def validate_amount(amount, product)
      raise Lib::MachineError.new('Insufficient funds.') if amount < product[:price]
    end

    def validate_coin(coin)
      raise Lib::MachineError.new('Not allowed coin.') unless ALLOWED_COINS.include?(coin.to_f)
    end

    private

    def product(product_id)
      Database::Adapter.instance.adapter.find_product(product_id.to_i)
    end
  end
end
