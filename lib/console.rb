require './lib/vending_machine'

module Lib
  class Console
    attr_reader :machine, :database

    def initialize
      @machine = VendingMachine.new
      @database = Database::Adapter.instance.adapter
    end

    def run
      main_screen
    end

    private

    def main_screen
      main_info
      main_actions
    end

    def main_info
      title = 'Vending Machine.'
      headings = ['Choosed Product ID', 'Choosed Product name', 'Balance', 'Machine Balance[Technical]']
      rows = [[machine.product[:id], machine.product[:name], machine.balance, machine.database.funds.to_s]]

      puts Terminal::Table.new title: title, headings: headings, rows: rows
    end

    def products_list
      perform_action do
        headings = ['Number of product', 'Name', 'Price', 'Quantity']
        title = 'There are the list of aviliable products:'
        rows = database.products.map(&:values)

        puts Terminal::Table.new title: title, headings: headings, rows: rows
        puts 'Type product id for select product.'

        machine.select_product(gets.chomp)
      end
    end

    def add_coin
      perform_action do
        puts 'You can use only 5, 3, 2, 1, 0.5, 0.25 $.'
        puts 'Type your coin value.'

        machine.add_coin(gets.chomp)
      end
    end

    def buy
      perform_action do
        machine.buy
        puts "Take your product, please - #{machine.product[:name]}"
      end
    end

    def change
      perform_action do
        puts 'Get your change, please.'

        machine.odd_money.each do |coin, value|
          puts "#{coin} - #{value}"
        end
      end
    end

    def main_actions
      puts '1 - Select product. 2 - Add coin to balance. 3 - Buy. 4 - Get change. 5 - Exit.'
      puts 'Type your choose.'

      case gets.chomp
      when '1'
        products_list
      when '2'
        add_coin
      when '3'
        buy
      when '4'
        change
      when '5'
        raise SystemExit
      end
    end

    def perform_action
      begin
        clear_screen
        yield
      rescue Lib::MachineError => e
        puts e.message
      end
      main_screen
    end

    def clear_screen
      system('clear')
    end
  end
end
