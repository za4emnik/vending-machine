require 'spec_helper'
require './lib/validation'

RSpec.describe Lib::Validation do
  subject(:validation) { Class.new { extend Lib::Validation } }

  describe '#validate_choose' do
    context 'when choose is not a number' do
      let(:choose) { 'abc' }

      it { expect { validation.validate_choose(choose) }.to raise_error }
    end

    context 'when product is not found' do
      let(:choose) { 100 }

      it 'returns error string' do
        expect(validation.validate_choose(choose)).to be_a(String)
      end
    end
  end
end
