require 'rails_helper'

RSpec.describe GetLatLongForAddress do
  describe "has attributes" do

    it "make api call to MapQuest and return lat and long" do
      VCR.use_cassette('mapquest successfull call denver') do
        get_lat_long_for_address = described_class.call({ address: "denver, co" })

        expect(get_lat_long_for_address.success?).to be(true)
      end
    end
  end
end