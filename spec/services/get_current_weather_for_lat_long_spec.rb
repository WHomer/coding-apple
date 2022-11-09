require 'rails_helper'

RSpec.describe GetCurrentWeatherForLatLong do
  describe "has attributes" do

    it "make api call to OpenWeather and return current weather" do
      VCR.use_cassette('openweather successfull call lat long') do
        get_current_weather_for_lat_long = described_class.call({ lat: 39.738453, long: -104.984853 })

        expect(get_current_weather_for_lat_long.success?).to be(true)
      end
    end
  end
end