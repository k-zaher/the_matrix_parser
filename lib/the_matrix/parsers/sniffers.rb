module TheMatrix
  module Parsers
    # Parser for Sniffers data
    module Sniffers
      extend TheMatrix::Utilities::Common
      extend TheMatrix::Utilities::Csv

      foreign_key 'node_time_id'

      class << self
        def create_routes(data, foreign_key = nil)
          normalized_data = normalize(@data['node_times'], foreign_key)
          data.each do |row|
            route_obj = TheMatrix::Route
                        .find_or_create(row['route_id'], module_name.downcase)
            results = join(@data['sequences'],
                           'route_id', route_obj.id, foreign_key)
            next_starting_time = nil
            results.each do |n_key|
              path, next_starting_time = build_path(row, normalized_data,
                                                    n_key, next_starting_time)
              if path
                route_obj.paths.push(path)
              else
                TheMatrix::Route.remove_and_report(row['route_id'])
                break
              end
            end
          end
        end

        def build_path(row, normalized_data, key, next_starting_time)
          path = TheMatrix::Path.new
          if next_starting_time.nil?
            path.start_time = row['time'], row['time_zone']
          end
          path.start_time = next_starting_time if next_starting_time
          start_node, end_node, duration_ms = extract_from(normalized_data, key,
                                                           'start_node',
                                                           'end_node',
                                                           'duration_in_milliseconds')
          path.start_node = start_node
          path.end_node = end_node
          path.end_time = get_time(duration_ms, path.start_time)
          return path, path.end_time
        rescue
          false
        end
      end
    end
  end
end
