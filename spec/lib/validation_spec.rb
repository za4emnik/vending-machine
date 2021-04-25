require 'spec_helper'
require './lib/validation'

RSpec.describe Lib::Validation do
  subject(:extended_validation) { Class.new { extend Lib::Validation } }

  describe '#validate_choose' do
    subject(:validation) { extended_validation.validate_choose(choose) }

    context 'when choose is not a number' do
      let(:choose) { 'abc' }

      it_behaves_like 'returns validation error'
    end

    context 'when product is not found' do
      let(:choose) { 100 }

      it_behaves_like 'returns validation error'
    end

    context 'when choose is correct' do
      let(:choose) { 1 }

      it { expect(validation).to be_nil }
    end
  end
end
