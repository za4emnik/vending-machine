module Database
  class Yaml
    require 'YAML'

    DATABASE_FILE = './data/data.yaml'.freeze

    # def initialize
    #   products = {
    #     products: [
    #       { id: 1, name: 'one', price: 100, count: 5 },
    #       { id: 2, name: 'two', price: 200, count: 10 },
    #       { id: 3, name: 'three', price: 300, count: 15 },
    #     ]
    #   }
    #   File.open(DATABASE_FILE, 'w') { |file| file.write(products.to_yaml) }
    # end

    def products
      YAML.safe_load(File.read(DATABASE_FILE))[:products]
    end
  end
end
