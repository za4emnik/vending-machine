module Helpers
  module DataHelper
    def funds(zero_balance: false)
      data = {
        products: [
          { id: 1, name: 'one', price: 5, quantity: 5 },
          { id: 2, name: 'two', price: 3, quantity: 10 },
          { id: 3, name: 'three', price: 0.5, quantity: 15 }
        ],
        funds: {
          0.25 => (zero_balance ? 0 : 10),
          0.5 => (zero_balance ? 0 : 10),
          1.0 => (zero_balance ? 0 : 10),
          2.0 => (zero_balance ? 0 : 10),
          3.0 => (zero_balance ? 0 : 10),
          5.0 => (zero_balance ? 0 : 10)
        }
      }

      yield(data) if block_given?
      data
    end
  end
end
