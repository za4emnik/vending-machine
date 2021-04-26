require './database/adapter'
require './lib/machine_error'

module Lib
  module Validation
    ALLOWED_COINS = [0.25, 0.5, 1.0, 2.0, 3.0, 5.0].freeze

    def validate_selected_product(product)
      raise default_error('Selected product do not exist.') if product.empty?
    end

    def validate_purchase(amount, product)
      raise default_error('Product is not selected. Please, select some product.') if product.empty?
      raise default_error('Product is out of stock. Please, select another one.') unless product[:quantity].positive?
      raise default_error('Insufficient funds.') if amount < product[:price]
    end

    def validate_coin(coin)
      raise default_error('Not allowed coin.') unless ALLOWED_COINS.include?(coin.to_f)
    end

    private

    def default_error(message)
      Lib::MachineError.new(message)
    end
  end
end
