RSpec.describe SolidusTracking::Tracker do
  describe '#options' do
    it 'returns the options' do
      tracker = described_class.new(foo: 'bar')

      expect(tracker.options).to eq(foo: 'bar')
    end
  end

  describe '#track' do
    it 'raises NotImplementedError' do
      tracker = described_class.new

      expect {
        tracker.track(nil)
      }.to raise_error(NotImplementedError)
    end
  end
end
