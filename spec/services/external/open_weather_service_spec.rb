require 'rails_helper'

RSpec.describe External::OpenWeatherService do
  describe "has attributes" do
    let(:open_weather_service) { described_class.new }

    it "make api call to OpenWeather and return current weather" do
      VCR.use_cassette('openweather successfull call lat long') do
  
        response = open_weather_service.get_current_weather_for_lat_long(39.738453, -104.984853)

        expect(response.status).to be(200)
        expect(response.body).to be_a(Hash)

        body = response.body
        expect(body["weather"][0]).to have_key("main")
        expect(body["weather"][0]).to have_key("description")
        expect(body["main"]).to have_key("temp")
        expect(body["main"]).to have_key("feels_like")
        expect(body["main"]).to have_key("humidity")
      end
    end
  end
end