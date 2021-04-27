require 'spec_helper'
require './lib/validation'
require './database/adapter'

RSpec.describe Lib::Validation do
  subject(:extended_validation) { Class.new { extend Lib::Validation } }

  let(:database) { Database::Adapter.instance.adapter }

  describe 'constants' do
    it 'ALLOWED_COINS has only permitted values' do
      expect(described_class::ALLOWED_COINS).to eq([0.25, 0.5, 1, 2, 3, 5])
    end
  end

  describe '#validate_selected_product' do
    subject(:validation) { extended_validation.validate_selected_product(product) }

    context 'when choosed product id is not a number' do
      let(:product) { database.find_product('abc') }

      it_behaves_like 'has validation error'
    end

    context 'when product is not found' do
      let(:product) { database.find_product(100) }

      it_behaves_like 'has validation error'
    end

    context 'when choose is found' do
      let(:product) { database.find_product(1) }

      it { expect { validation }.not_to raise_error }
    end
  end

  describe '#validate_purchase' do
    subject(:validation) { extended_validation.validate_purchase(amount, product) }

    let(:product) { { price: 10, quantity: 1 } }
    let(:amount) { 100 }

    context 'when amount is less than product price' do
      let(:amount) { 1 }

      it_behaves_like 'has validation error'
    end

    context 'when amount is equal to the product price' do
      let(:amount) { 10 }

      it { expect { validation }.not_to raise_error }
    end

    context 'when amount is more than product price' do
      let(:amount) { 100 }

      it { expect { validation }.not_to raise_error }
    end

    context 'when product is not selected' do
      let(:product) { {} }

      it_behaves_like 'has validation error'
    end

    context 'when product is out of stock' do
      let(:product) { { quantity: 0 } }

      it_behaves_like 'has validation error'
    end
  end
end
