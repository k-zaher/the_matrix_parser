require 'spec_helper'

describe TheMatrix::Parser do
  describe '.parse_data' do
    it 'returns the an array of flattened data' do
      allow(TheMatrix::Parsers::Loopholes).to receive(:parse) { [true] }
      allow(TheMatrix::Parsers::Sentinels).to receive(:parse) { [true] }
      allow(TheMatrix::Parsers::Sniffers).to receive(:parse) { [true] }

      expect(TheMatrix::Parser.parse_data).to eql [true, true, true]
    end
  end
end
