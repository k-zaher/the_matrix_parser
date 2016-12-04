require 'time'
module TheMatrix
  # a representation of the path
  class Path
    attr_accessor :start_time, :end_time, :start_node, :end_node

    def start_time=(input)
      time, time_zone = input
      if time_zone
        time_zone = time_zone.tr('UTC', '').tr('±', '+')
        @start_time = Time.parse(time + time_zone).utc.iso8601
      else
        @start_time = Time.parse(time).utc.iso8601
      end
    end

    def end_time=(input)
      time, time_zone = input
      if time_zone
        time_zone = time_zone.tr('UTC', '').tr('±', '+')
        @end_time = Time.parse(time + time_zone).utc.iso8601
      else
        @end_time = Time.parse(time).utc.iso8601
      end
    end
  end
end
