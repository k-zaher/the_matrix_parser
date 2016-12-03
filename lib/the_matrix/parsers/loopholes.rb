module TheMatrix
  module Parsers
    # Parser for Loopholes data
    module Loopholes
      extend TheMatrix::Utilities::Common
      extend TheMatrix::Utilities::Json

      foreign_key 'node_pair_id'

      class << self
        def create_routes(data, foreign_key)
          normalized_paths = normalize(@data['node_pairs'], 'id')
          data.each do |route|
            route_obj = TheMatrix::Route.find_or_create(route['route_id'],
                                                        module_name.downcase)
            path = build_path(route, normalized_paths, foreign_key)
            route_obj.paths.push(path)
          end
        end

        def build_path(route, normalized_paths, foreign_key)
          path = TheMatrix::Path.new
          path.start_time = route['start_time']
          path.end_time = route['end_time']
          path.start_node, path.end_node = extract_from(normalized_paths,
                                                        route[foreign_key],
                                                        'start_node',
                                                        'end_node')
          path
        end
      end
    end
  end
end
