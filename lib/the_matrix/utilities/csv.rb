require 'csv'
module TheMatrix
  module Utilities
    # Helper Module for CSV formated data
    module Csv
      def open_and_parse(files)
        output = {}
        files.each do |file|
          file_name =  File.basename(file).gsub('.csv', '')
          file_content = File.read(file).gsub(', ', ',')
          output[file_name] = CSV.parse(file_content, headers: :first_row)
        end
        output
      end

      def normalize(data, primary_key)
        hash = {}
        data.each do |obj|
          obj = obj.to_hash
          hash[obj.delete(primary_key)] = obj
        end
        hash
      end

      def join(data, primary_key, value, foreign_key)
        data.reject { |row| row[primary_key] != value }
            .map { |row| row[foreign_key] }
      end
    end
  end
end
