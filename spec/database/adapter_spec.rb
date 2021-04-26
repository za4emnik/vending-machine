require 'spec_helper'
require './database/adapter'
require './database/memory'

RSpec.describe Database::Adapter do
  subject(:adapter) { described_class.instance.adapter }

  describe '#adapter' do
    it 'returns default memory adapter' do
      expect(adapter).to be_a(Database::Memory)
    end

    it 'can not create new object' do
      expect { described_class.new }.to raise_error(NoMethodError)
    end
  end
end
