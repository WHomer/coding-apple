require 'rails_helper'

RSpec.describe WeatherPoro do
  describe "has attributes" do
    let(:weather_poro) {
      described_class.new(
        "Clear",
        "Very Sunny Out",
        89.6,
        106.4,
        89.97
      )
    }

    it { expect(weather_poro).to respond_to(:condition) }
    it { expect(weather_poro).to respond_to(:description) }
    it { expect(weather_poro).to respond_to(:temp) }
    it { expect(weather_poro).to respond_to(:feels_like) }
    it { expect(weather_poro).to respond_to(:humidity) }
  end
end