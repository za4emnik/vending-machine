require 'spec_helper'
require './database/yaml'

RSpec.describe Database::Yaml do
  subject(:database) { described_class.new }

  let(:database_file) { './spec/fixtures/data.yaml' }
  let(:products) { YAML.safe_load(File.read(database_file))[:products] }

  before { stub_const('Database::Yaml::DATABASE_FILE', database_file) }

  context '#products' do
    it 'returns full list of products' do
      expect(subject.products.count).to eq(products.count)
    end
  end
end
