require 'spec_helper'
require './lib/vending_machine'
require './lib/validation'

RSpec.describe Lib::VendingMachine do
  include Helpers::DataHelper

  subject(:machine) { described_class.new }

  let(:product_id) { 1 }

  describe 'constants' do
    it 'ALLOWED_COINS has only permitted values' do
      expect(described_class::ALLOWED_COINS).to eq([0.25, 0.5, 1, 2, 3, 5])
    end
  end

  describe 'accessors' do
    # it 'has money attribute accessor' do
    #   expect(machine).to have_attr_accessor(:money)
    # end

    # it 'has database attribute reader' do
    #   expect(machine).to have_attr_reader(:database)
    # end
  end

  describe '#initialize' do
    it 'has database kind of default database Memory adapter' do
      expect(machine.database).to be_a(Database::Memory)
    end
  end

  describe '#add_coin' do
    context 'when coin is not allowed' do
      it 'raise validation error' do
        expect { machine.add_coin(0.75) }.to raise_error(Lib::MachineError)
      end
    end

    context 'when coin is allowed' do
      let(:coin) { '0.5' }
      let!(:funds) { machine.database.funds[coin.to_f] }

      before { machine.add_coin(coin) }

      it 'should increase balance' do
        expect(machine.balance).to eq(0.5)
      end

      it 'adds coin to the machine funds' do
        expect(machine.database.funds[coin.to_f]).to eq(funds + 1)
      end
    end
  end

  describe '#select_product' do
    context 'when selected product is valid' do
      before { machine.select_product(1) }

      it 'do not raise validation error' do
        expect(machine.instance_variable_get(:@product_id)).to eq(1)
      end
    end

    context 'when selected product is not valid' do
      it 'raise validation error' do
        expect { machine.select_product(555) }.to raise_error(Lib::MachineError)
      end

      it 'do not set product_id to machine' do
        machine.select_product(555)
      rescue Lib::MachineError
        expect(machine.instance_variable_get(:@product_id)).to be_nil
      end
    end
  end

  describe '#buy' do
    context 'when insufficient funds' do
      before do
        machine.select_product(product_id)
        machine.add_coin(0.25)
      end

      let!(:product_quantity) { machine.product[:quantity] }

      it 'do not decrease product quantity' do
        machine.buy
      rescue Lib::MachineError
        expect(machine.database.find_product(product_id)[:quantity]).to eq(product_quantity)
      end
    end

    context 'when buy is success' do
      let!(:product_quantity) { product[:quantity] }
      let(:product) { machine.database.find_product(product_id) }

      before do
        machine.add_coin(5)
        machine.add_coin(3)
        machine.select_product(product_id)
      end

      it 'decrease product quantity' do
        machine.buy
        expect(machine.database.find_product(product_id)[:quantity]).to eq(product_quantity - 1)
      end

      it 'decrease balance' do
        machine.buy
        expect(machine.balance).to eq(3)
      end
    end
  end

  describe 'give_rest' do
    context 'when enough coins in machine' do
      before do
        stub_const('Database::Memory::DATA', funds(zero_balance: true))

        machine.add_coin(5)
        machine.add_coin(3)
        machine.add_coin(2)
        machine.add_coin(1)
        machine.add_coin(0.5)
        machine.add_coin(0.25)
      end

      let(:expected_result) { { 5.0 => 1, 3.0 => 1, 2.0 => 1, 1.0 => 1, 0.5 => 1, 0.25 => 1 } }

      it 'returns rest' do
        expect(machine.give_rest).to eq(expected_result)
      end
    end

    context 'when not enough funds in machine' do
      before do
        stub_const('Database::Memory::DATA', stubbed_funds)
        machine.instance_variable_set(:@balance, 11.25)
      end

      let(:stubbed_funds) do
        funds(zero_balance: true) do |data|
          data[:funds][5.0] = 1
          data[:funds][0.5] = 10
        end
      end
      let(:expected_result) { { 5.0 => 1, 3.0 => 0, 2.0 => 0, 1.0 => 0, 0.5 => 10, 0.25 => 0 } }

      it 'returns several 0.5 coins' do
        expect(machine.give_rest).to eq(expected_result)
      end

      it 'save the rest to balance' do
        machine.give_rest
        expect(machine.balance).to eq(1.25)
      end
    end

    it 'remove selected product' do
      machine.give_rest
      expect(machine.product).to eq({})
    end
  end

  describe '#product' do
    before { machine.select_product(product_id) }

    it 'returns selected product' do
      expect(machine.product).to eq(machine.database.find_product(product_id))
    end
  end
end
