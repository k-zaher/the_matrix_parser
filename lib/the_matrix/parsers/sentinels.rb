require 'csv'
module TheMatrix
  module Parsers
    # Parser for Sentinels data
    module Sentinels
      extend TheMatrix::Utilities::Common
      extend TheMatrix::Utilities::Csv

      class << self
        def create_routes(data, _foreign_key)
          input = {}
          data.each do |row|
            route_id = row['route_id']
            indx = row['index'].to_i
            path = TheMatrix::Path.new
            path.start_node = row['node']
            path.start_time = row['time']
            input[route_id] = {} if input[route_id].nil?
            input[route_id][indx] = path
            fix_from_neighbours(row, input)
          end
          construct(input)
        end

        def fix_from_neighbours(data, input)
          route_id = data['route_id']
          indx = data['index'].to_i
          if (prev_path = input[route_id][indx - 1])
            prev_path.end_node = data['node']
            prev_path.end_time = data['time']
          end
          if (next_path = input[route_id][indx + 1])
            path.end_node = next_path.start_node
            path.end_time = next_path.start_time
          end
        end

        def construct(input)
          input.each do |key, value|
            route_obj = TheMatrix::Route.find_or_create(key,
                                                        module_name.downcase)
            if value.keys.count == 1
              TheMatrix::Route.remove_and_report(key)
              next
            end
            (value.keys.count - 1).times do |i|
              route_obj.paths << value[i]
            end
          end
        end
      end
    end
  end
end
