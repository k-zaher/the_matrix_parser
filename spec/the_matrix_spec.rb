require 'spec_helper'

describe TheMatrix do
  it 'has a version number' do
    expect(TheMatrix::VERSION).not_to be nil
  end

  describe '.root' do
    it 'returns the correct root path' do
      expect(TheMatrix.root).to eql((File.dirname __dir__))
    end
  end

  describe '.data_path' do
    it 'returns the correct root path' do
      expect(TheMatrix.data_path).to eql((File.join TheMatrix.root, 'data'))
    end
  end
end
