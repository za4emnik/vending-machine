require './database/adapter'

module Lib
  class Validation
    attr_reader :errors

    def initialize
      @errors = []
    end

    def validate_choose(product_id)
      add_error('You can to type only number of the product.') if product_id.to_i.zero?
      add_error('Selected product do not exist. Please, try again.') if product(product_id).empty?
      return_boolean_value
    end

    def validate_amount(amount, product)
      add_error('Insufficient funds.') if amount < product[:price]
      return_boolean_value
    end

    private

    def product(product_id)
      Database::Adapter.instance.adapter.find_product(product_id.to_i)
    end

    def add_error(message)
      @errors << message
    end

    def return_boolean_value
      @errors.empty?
    end
  end
end
