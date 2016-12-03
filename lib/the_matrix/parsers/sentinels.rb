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
          data.each do |route|
            route_id = route['route_id']
            indx = route['index'].to_i
            path = TheMatrix::Path.new
            path.start_node = route['node']
            path.start_time = route['time']
            input[route_id] = {} if input[route_id].nil?
            input[route_id][indx] = path
            fix_from_neighbours(route, input)
          end
          construct(input)
        end

        def fix_from_neighbours(route, input)
          route_id = route['route_id']
          indx = route['index'].to_i
          prev_path = input[route_id][indx - 1]
          next_path = input[route_id][indx + 1]
          prev_path.end_node = route['node'] if prev_path
          path.end_node = next_path.start_node if next_path
        end

        def construct(input)
          input.each do |key, value|
            next if value.keys.count == 1
            route_obj = TheMatrix::Route.find_or_create(key,
                                                        module_name.downcase)
            (value.keys.count - 1).times do |i|
              route_obj.paths << value[i]
            end
          end
        end
      end
    end
  end
end
