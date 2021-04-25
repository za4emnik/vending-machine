require 'spec_helper'
require './database/yaml'

RSpec.describe Database::Yaml do
  subject(:database) { described_class.new }

  let(:database_file) { './spec/fixtures/data.yaml' }
  let(:products) { YAML.safe_load(File.read(database_file), permitted_classes: [Symbol])[:products] }

  before { stub_const('Database::Yaml::DATABASE_FILE', database_file) }

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
end
