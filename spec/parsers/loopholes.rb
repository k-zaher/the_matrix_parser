require 'spec_helper'

describe TheMatrix::Utilities::Loopholes do
  describe '.open_and_parse' do
    before(:each) do
      @klass = TheMatrix::Parsers::Loopholes
    end
    it 'returns the a hash of parsed csv' do
      files = Dir["#{TheMatrix.data_path}/#{@klass.module_name.downcase}/*"]
      expect(@klass.locate_files).to eql files

      expect(@klass.open_and_parse(files).count).to eql files.count

      expect(@klass.open_and_parse(files).keys).to eql %w(node_pairs routes)
    end
  end
end
