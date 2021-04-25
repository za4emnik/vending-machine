require 'spec_helper'
require './lib/validation'

RSpec.describe Lib::Validation do
  subject(:validation) { described_class.new }

  describe '#initialize' do
    it 'initialize error with empty array' do
      expect(validation.errors).to eq([])
    end
  end

  describe '#validate_choose' do
    before { validation.validate_choose(choose) }

    context 'when choose is not a number' do
      let(:choose) { 'abc' }

      it_behaves_like 'has validation error'
    end

    context 'when product is not found' do
      let(:choose) { 100 }

      it_behaves_like 'has validation error'
    end

    context 'when choose is correct' do
      let(:choose) { 1 }

      it { expect(validation.errors).to be_empty }
    end
  end

  describe '#validate_amount' do
    before { validation.validate_amount(amount, product) }

    let(:product) { { price: 10 } }

    context 'when amount is less than product price' do
      let(:amount) { 1 }

      it_behaves_like 'has validation error'
    end

    context 'when amount is equal to the product price' do
      let(:amount) { 10 }

      it { expect(validation.errors).to be_empty }
    end

    context 'when amount is more than product price' do
      let(:amount) { 100 }

      it { expect(validation.errors).to be_empty }
    end
  end
end
