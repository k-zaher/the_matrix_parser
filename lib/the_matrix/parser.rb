require 'the_matrix/parsers/loopholes'
require 'the_matrix/parsers/sentinels'
require 'the_matrix/parsers/sniffers'
module TheMatrix
  # Runner Module
  module Parser
    SUPPORTED_INPUTS = %w(loopholes sentinels sniffers).freeze

    class << self
      def parse_data
        parsed_data = []
        SUPPORTED_INPUTS.each do |source|
          klass = Object.const_get "TheMatrix::Parsers::#{source.capitalize}"
          parsed_data << klass.parse
        end
        parsed_data.flatten
      end
    end
  end
end
