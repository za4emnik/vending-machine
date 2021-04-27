module Database
  class Memory
    DATA = {
      products: [
        { id: 1, name: 'Bottle of water.', price: 1.25, quantity: 3 },
        { id: 2, name: 'The juice', price: 3.75, quantity: 5 },
        { id: 3, name: 'Beer', price: 7.50, quantity: 10 }
      ],
      funds: {
        0.25 => 10,
        0.5 => 10,
        1.0 => 10,
        2.0 => 10,
        3.0 => 10,
        5.0 => 10
      }
    }.freeze

    def initialize
      @data = DATA.dup
    end

    def products
      @data[:products]
    end

    def find_product(id)
      @data[:products].detect { |product| product[:id] == id.to_i } || {}
    end

    def funds
      @data[:funds]
    end

    def add_coin(coin)
      @data[:funds][coin.to_f] += 1
    end

    def drop_coin(coin)
      @data[:funds][coin.to_f] -= 1
    end

    def decrease_product_quantity(product)
      @data[:products].map do |product_item|
        product_item[:quantity] -= 1 if product_item[:id] == product[:id]
        product_item
      end
    end
  end
end
