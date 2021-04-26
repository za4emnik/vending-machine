require 'spec_helper'
require './database/memory'

RSpec.describe Database::Memory do
  subject(:database) { described_class.new }

  let(:products) { database.instance_variable_get(:@data)[:products] }
  
  describe '#products' do
    it 'returns full list of products' do
      expect(database.products.count).to eq(products.count)
    end
  end

  describe '#find_product' do
    context 'when product exists in the database' do
      it 'returns object' do
        expect(database.find_product(1)).not_to be_empty
      end
    end

    context 'when product not exists in the database' do
      it { expect(database.find_product(100)).to eq({}) }
    end
  end

  describe '#balance' do
    it 'returns odd money' do
      expect(database.balance).to eq(described_class::DATA[:balance])
    end
  end

  describe '#add_coin' do
    let(:coin) { '0.5' }
    let!(:odd_coin) { database.balance[coin.to_f] }

    it 'increase coin count' do
      database.add_coin(coin)
      expect(database.balance[coin.to_f]).to eq(odd_coin + 1)
    end
  end

  describe '#decrease_product_quantity' do
    let!(:product_quantity) { product[:quantity] }
    let(:product) { database.find_product(product_id) }
    let(:product_id) { 1 }

    it 'decrease product quantity by 1' do
      database.decrease_product_quantity(product)
      expect(database.find_product(product_id)[:quantity]).to eq(product_quantity - 1)
    end
  end
end
