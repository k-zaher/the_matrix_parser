require 'spec_helper'

describe TheMatrix::Path do
  describe '.start_time=' do
    before(:each) do
      @obj = TheMatrix::Path.new
    end

    it 'sets the correct start_time' do
      @obj.start_time = '2030-12-31T13:00:04Z'
      expect(@obj.start_time).to eql '2030-12-31T13:00:04Z'
    end

    it 'sets the correct start_time and time zone' do
      @obj.start_time = '2030-12-31T13:00:06', 'UTC±00:00'
      expect(@obj.start_time).to eql '2030-12-31T13:00:06Z'

      @obj.start_time = '2030-12-31T13:00:06', '+02:00'
      expect(@obj.start_time).to eql '2030-12-31T11:00:06Z'

      @obj.start_time = '2030-12-31T13:00:06', '-02:00'
      expect(@obj.start_time).to eql '2030-12-31T15:00:06Z'
    end
  end
end
