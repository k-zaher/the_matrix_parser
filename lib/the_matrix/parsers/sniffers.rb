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
          data.each do |route|
            route_obj = TheMatrix::Route
                        .find_or_create(route['route_id'], module_name.downcase)
            results = join(@data['sequences'],
                           'route_id', route_obj.id, foreign_key)
            results.each do |n_key|
              path = build_path(route, normalized_data, n_key)
              route_obj.paths.push(path)
            end
          end
        end

        def build_path(route, normalized_data, key)
          path = TheMatrix::Path.new
          path.start_time = route['time'], route['time_zone']
          x, y, duration = extract_from(normalized_data, key,
                                        'start_node',
                                        'end_node',
                                        'duration_in_milliseconds')
          path.start_node = x
          path.end_node = y
          path.end_time = get_time(duration, path.start_time)
          path
        end
      end
    end
  end
end
