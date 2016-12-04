module TheMatrix
  module Utilities
    # Helper Module for Shared Functions
    module Common
      def locate_files
        Dir["#{TheMatrix.data_path}/#{module_name.downcase}/*"]
      end

      def foreign_key(key)
        @foreign_key = key
      end

      def parse
        files = locate_files
        @data = open_and_parse(files)
        create_routes(@data['routes'], @foreign_key)
        data = TheMatrix::Route.parsed_data
        TheMatrix::Route.clear_collector
        data
      end

      def module_name
        name.gsub('TheMatrix::Parsers::', '')
      end

      def get_time(duration_in_ms, starting_time)
        (Time.parse(starting_time) + (duration_in_ms.to_i / 1000)).utc.iso8601
      end

      def extract_from(data, value, *keys)
        data[value].reject { |k| !keys.include?(k) }.values
      end
    end
  end
end
