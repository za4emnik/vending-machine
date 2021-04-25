require 'spec_helper'
require './lib/vending_machine'
require './lib/validation'

RSpec.describe Lib::VendingMachine do
  subject(:machine) { described_class.new }

  describe 'constants' do
    it 'ALLOWED_COINS has only permitted values' do
      expect(described_class::ALLOWED_COINS).to eq([0.25, 0.5, 1, 2, 3, 5])
    end
  end

  describe 'accessors' do
    it 'has product_id attribute accessor' do
      expect(machine).to have_attr_accessor(:product_id)
    end

    it 'has money attribute accessor' do
      expect(machine).to have_attr_accessor(:money)
    end

    it 'has database attribute reader' do
      expect(machine).to have_attr_reader(:database)
    end

    it 'has errors attribute reader' do
      expect(machine).to have_attr_reader(:errors)
    end
  end

  describe '#initialize' do
    it 'has database kind of default database Yaml adapter' do
      expect(machine.database).to be_a(Database::Yaml)
    end

    it 'has validation kind of Lib::Validation' do
      expect(machine.instance_variable_get(:@validation)).to be_a(Lib::Validation)
    end
  end

  describe '#buy' do
    context 'when insufficient funds' do
      let!(:product_quantity) { product[:quantity] }
      let(:product) { machine.database.find_product(product_id) }
      let(:product_id) { 1 }

      before do
        machine.money = 1
        machine.product_id = product_id
      end

      it 'do not decrease product quantity' do
        machine.buy
        expect(machine.database.find_product(product_id)[:quantity]).to eq(product_quantity)
      end

      it 'returns false result' do
        expect(machine.buy).to be_falsey
      end
    end

    context 'when buy is success' do
      let!(:product_quantity) { product[:quantity] }
      let(:product) { machine.database.find_product(product_id) }
      let(:product_id) { 1 }

      before do
        machine.money = 100_000
        machine.product_id = product_id
      end

      it 'decrease product quantity' do
        machine.buy
        expect(machine.database.find_product(product_id)[:quantity]).to eq(product_quantity - 1)
      end

      it 'returns true result' do
        expect(machine.buy).to be_truthy
      end
    end
  end
end
