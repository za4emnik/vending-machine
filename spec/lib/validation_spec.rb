require 'spec_helper'
require './lib/validation'

RSpec.describe Lib::Validation do
  subject(:extended_validation) { Class.new { extend Lib::Validation } }

  describe '#validate_choose' do
    subject(:validation) { extended_validation.validate_choose(choose) }

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

      it { expect { validation }.not_to raise_error }
    end
  end

  describe '#validate_amount' do
    subject(:validation) { extended_validation.validate_amount(amount, product) }

    let(:product) { { price: 10 } }

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
  end
end
