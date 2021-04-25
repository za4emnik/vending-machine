RSpec.shared_examples 'has validation error' do
  it 'has error message' do
    expect(validation.errors).not_to be_empty
  end
end
