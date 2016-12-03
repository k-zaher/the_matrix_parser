require 'spec_helper'

describe TheMatrix::Route do
  include_context 'route_helper'
  describe '.parsed_data' do
    it 'returns all instances of TheMatrix::Route' do
      obj = TheMatrix::Route.new(1, 'test')
      expect(TheMatrix::Route.parsed_data).to eql [obj]
    end
  end

  describe '.clear_data' do
    it 'returns all instances of TheMatrix::Route' do
      TheMatrix::Route.new(1, 'test')
      TheMatrix::Route.clear_collector
      expect(TheMatrix::Route.parsed_data).to eql []
    end
  end

  describe '.find_or_create' do
    it "doesn't create a new object if exists" do
      obj = TheMatrix::Route.new(1, 'test')
      expect(TheMatrix::Route.find_or_create(1, 'test')).to eql obj
    end

    it 'creates a new object if obj not exists' do
      obj = TheMatrix::Route.new(1, 'test')
      expect(TheMatrix::Route.find_or_create(2, 'test')).not_to eq obj
    end
  end

  describe '.clear_data' do
    it 'returns a json format of the route' do
      obj = TheMatrix::Route.new(1, 'test')
      path = create_sample_node('gamma', '2030-12-31T13:00:04Z',
                                'beta', '2030-12-31T13:00:05Z')
      path2 = create_sample_node('beta', '2030-12-31T13:00:05Z',
                                 'zeta', '2030-12-31T13:00:06Z')
      obj.paths.push(path, path2)
      expect(obj.to_json).to eq parsed_route
    end
  end
end
