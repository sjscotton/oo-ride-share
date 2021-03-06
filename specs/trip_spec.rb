require_relative "spec_helper"

describe "Trip class" do
  describe "initialize" do
    before do
      start_time = Time.parse("2015-05-20T12:14:00+00:00")
      end_time = start_time + 25 * 60 # 25 minutes
      @trip_data = {
        id: 8,
        passenger: RideShare::Passenger.new(id: 1,
                                            name: "Ada",
                                            phone_number: "412-432-7640"),
        start_time: start_time.to_s,
        end_time: end_time.to_s,
        cost: 23.45,
        rating: 3,
        driver_id: 1,
      }
      @trip = RideShare::Trip.new(@trip_data)
    end

    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end

    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do # Unskip after wave 2
      new_driver = RideShare::Driver.new(
        id: 3,
        name: "Test Driver",
        vin: "12345678912345678",
      )
      @trip.driver = new_driver
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end

    it "ensures start time is an instance of Time" do
      expect(@trip.start_time).must_be_kind_of Time
    end

    it "ensures end time is an instance of Time" do
      expect(@trip.end_time).must_be_kind_of Time
    end

    it "calculates the duration of the trip in seconds" do
      expect(@trip.duration).must_equal 1500
    end

    it "ensures start time is after end time" do
      @trip_data[:start_time], @trip_data[:end_time] = @trip_data[:end_time], @trip_data[:start_time]
      expect { RideShare::Trip.new(@trip_data) }.must_raise ArgumentError
    end
  end
end
