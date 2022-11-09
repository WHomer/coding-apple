#
# Input:
#   context.address: String
#
# Output:
#   context.lat: Float
#   context.long: Float
#

class GetLatLongForAddress
  include Interactor

  delegate :address, :lat, :long, :response, to: :context

  def call
    get_lat_long_for_address_from_map_quest
    validate_response
  end

  private

  def validate_response
    fail_with_bad_request unless response.status == 200
    fail_with_bad_response unless set_first_address_lat_long
  end

  def set_first_address_lat_long
    coordinates = response.body["results"][0]["locations"][0]["latLng"] rescue nil
    context.lat = coordinates["lat"] if coordinates
    context.long = coordinates["lng"] if coordinates
  end

  def fail_with_bad_request
    context.fail!(error_message: 'Invalid response from lat/long service')
  end

  def fail_with_bad_response
    context.fail!(error_message: 'Failed to get lat/long from address')
  end

  def get_lat_long_for_address_from_map_quest
    cache_key = "map_quest/lat_long/#{address}"
    context.response = Rails.cache.fetch cache_key, expires_in: 30.minutes do
      map_quest_service.get_latlong_for_address(address)
    end
  end

  def map_quest_service
    External::MapQuestService.new
  end
end