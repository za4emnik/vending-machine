require 'singleton'
require './database/memory'

module Database
  class Adapter
    include Singleton

    def adapter
      Kernel.const_get("Database::#{Settings.data_adapter.capitalize}").new
    end
  end
end
