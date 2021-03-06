require_relative 'csv_record'
require 'time'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: nil)
      super(id)
      @name = name
      @phone_number = phone_number
      @trips = trips || []
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      return @trips.map {|trip| trip.cost}.sum
    end

    def total_time_spent
      return @trips.map {|trip| trip.trip_duration_in_seconds}.sum 
    end

    private

    def self.from_csv(record)
      return self.new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end