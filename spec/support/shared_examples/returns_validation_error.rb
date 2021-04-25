RSpec.shared_examples 'returns validation error' do
  it 'returns error message' do
    expect(validation).to be_a(String)
  end
end
