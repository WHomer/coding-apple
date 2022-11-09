require 'rails_helper'

RSpec.describe External::MapQuestService do
  describe "has attributes" do
    let(:map_quest_service) { described_class.new }

    it "make api call to MapQuest and return lat and long" do
      VCR.use_cassette('mapquest successfull call denver') do
  
        response = map_quest_service.get_latlong_for_address("denver, co")

        expect(response.status).to be(200)
        expect(response.body).to be_a(Hash)

        location = response.body["results"][0]["locations"][0]
        expect(location).to have_key("adminArea5")
        expect(location).to have_key("adminArea4")
        expect(location["latLng"]).to have_key("lat")
        expect(location["latLng"]).to have_key("lng")
      end
    end
  end
end