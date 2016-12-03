shared_context 'route_helper' do
  def parsed_route
    {
      source: 'test',
      start_node: 'gamma',
      end_node: 'zeta',
      start_time: '2030-12-31T13:00:04Z',
      end_time: '2030-12-31T13:00:06Z'
    }
  end

  def create_sample_node(start_node, start_time, end_node, end_time)
    path = TheMatrix::Path.new
    path.start_node = start_node
    path.start_time = start_time
    path.end_node = end_node
    path.end_time = end_time
    path
  end
end
