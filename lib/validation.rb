require './database/adapter'

module Lib
  module Validation
    def validate_choose(choose)
      raise 'You can to type only number of the product.' if choose.to_i.zero?
      return 'Selected product do not exist. Please, try again.' if product_not_found?(choose)
    end

    private

    def product_not_found?(choose)
      !Database::Adapter.instance.adapter.find_product(choose.to_i)&.empty?
    end
  end
end
