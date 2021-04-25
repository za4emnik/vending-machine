require 'spec_helper'
require './lib/vending_machine'

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
      expect(console.database).to be_a(Database::Yaml)
    end
  end

  # describe '#pay' do
  #   it ''
  # end
end
