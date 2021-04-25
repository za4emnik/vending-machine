require 'spec_helper'
require './lib/console'
# require 'shared_examples_for_console.rb'

RSpec.describe Lib::Console do
  subject(:console) { described_class.new }

  describe '#initialize' do
    it 'has machine kind of VendingMachine' do
      expect(console.machine).to be_a(VendingMachine)
    end

    it 'has database kind of default database Yaml adapter' do
      expect(console.database).to be_a(Database::Yaml)
    end
  end

  describe '#run' do
    context 'when number of product is not correct' do
      it { expect { console.run }.to raise_error }
    end
  end
end
