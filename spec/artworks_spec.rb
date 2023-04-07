describe Artworks do
  subject(:result) { Artworks.run(path) }
  let(:path) { "foo" }
  let(:double_result) { double(parse: 'hello world') }

  before do
    allow(GoogleParser).to receive(:new).and_return(double_result)
  end

  it 'calls GoogleParser with correct args' do
    subject
    expect(GoogleParser).to have_received(:new).with("file://#{path}")
  end

  it 'outputs the result on standard output' do
    expect { result }.to output("hello world\n").to_stdout
  end
end
