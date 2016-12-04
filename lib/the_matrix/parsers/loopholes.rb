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
          data.each do |row|
            route_obj = TheMatrix::Route.find_or_create(row['route_id'],
                                                        module_name.downcase)
            output = build_path(row, normalized_paths, foreign_key)
            if output
              route_obj.paths.push(output)
            else
              TheMatrix::Route.remove_and_report(row['route_id'])
            end
          end
        end

        def build_path(row, normalized_paths, foreign_key)
          path = TheMatrix::Path.new
          path.start_time = row['start_time']
          path.end_time = row['end_time']
          path.start_node, path.end_node = extract_from(normalized_paths,
                                                        row[foreign_key],
                                                        'start_node',
                                                        'end_node')
          path
        rescue
          false
        end
      end
    end
  end
end
