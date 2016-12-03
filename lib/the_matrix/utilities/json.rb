require 'json'
module TheMatrix
  module Utilities
    # Helper Module for Json formated data
    module Json
      def normalize(data, primary_key)
        hash = {}
        data.each do |obj|
          hash[obj.delete(primary_key)] = obj
        end
        hash
      end

      def open_and_parse(files)
        output = {}
        files.each do |file|
          file_name =  File.basename(file).gsub('.json', '')
          file_content = File.read(file)
          output[file_name] = JSON.parse(file_content)[file_name]
        end
        output
      end
    end
  end
end
