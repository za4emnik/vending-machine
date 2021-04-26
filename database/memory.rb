module Database
  class Memory

    DATA = {
      products: [
        { id: 1, name: 'one', price: 100, quantity: 5 },
        { id: 2, name: 'two', price: 200, quantity: 10 },
        { id: 3, name: 'three', price: 300, quantity: 15 }
      ],
      balance: {
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
      @data[:products].detect { |product| product[:id] == id } || {}
    end

    def balance
      @data[:balance]
    end

    def add_coin(coin)
      @data[:balance][coin.to_f] += 1
    end

    def decrease_product_quantity(product)
      @data[:products].map do |product_item|
        product_item[:quantity] = product_item[:quantity] - 1 if product_item[:id] == product[:id]
        product_item
      end
    end
  end
end
