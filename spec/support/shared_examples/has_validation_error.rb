RSpec.shared_examples 'has validation error' do
  it 'has error message' do
    expect { validation }.to raise_error(Lib::MachineError)
  end
end
