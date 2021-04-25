module Database
  class Yaml
    require 'YAML'

    DATABASE_FILE = './data/data.yaml'.freeze

    # def initialize
    #   products = {
    #     products: [
    #       { id: 1, name: 'one', price: 100, quantity: 5 },
    #       { id: 2, name: 'two', price: 200, quantity: 10 },
    #       { id: 3, name: 'three', price: 300, quantity: 15 }
    #     ]
    #   }
    #   File.open(DATABASE_FILE, 'w') { |file| file.write(products.to_yaml) }
    # end

    def products
      load_data[:products]
    end

    def find_product(id)
      load_data[:products].detect { |product| product[:id] == id } || {}
    end

    def decrease_product_quantity(product)
      load_data[:products].map do |product_item|
        product_item[:quantity] = product_item[:quantity] - 1 if product_item[:id] == product[:id]
        product_item
      end

      save(load_data)
    end

    private

    def load_data
      @load_data ||= YAML.safe_load(File.read(DATABASE_FILE), permitted_classes: [Symbol])
    end

    def save(object)
      File.open(DATABASE_FILE, 'w') { |file| file.write(object.to_yaml) }
    end
  end
end
