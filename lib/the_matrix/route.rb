module TheMatrix
  # a representation of the route
  class Route
    attr_accessor :id, :paths, :source

    @@instance_collector_mapper = {}
    @@instance_collector = []

    def self.find_or_create(route_id, source)
      if (obj = @@instance_collector_mapper[route_id.to_i])
        obj
      else
        new(route_id, source)
      end
    end

    def self.parsed_data
      @@instance_collector
    end

    def self.remove_and_report(id)
      obj = @@instance_collector_mapper[id.to_i]
      @@instance_collector.delete(obj)
      @@instance_collector_mapper[id.to_i] = nil

      p "******* Warning ******* Route ##{id} in #{obj.source}"\
      ' is invalid and has been IGNORED  *********************'
    end

    def self.clear_collector
      @@instance_collector_mapper = {}
      @@instance_collector = []
    end

    def initialize(id, source)
      @id = id
      @source = source
      @paths = []
      @@instance_collector << self
      @@instance_collector_mapper[@id.to_i] = self
    end

    def to_json
      {
        source: @source,
        start_node: @paths.first.start_node,
        end_node: @paths.last.end_node,
        start_time: @paths.first.start_time,
        end_time: @paths.last.end_time
      }
    end
  end
end
