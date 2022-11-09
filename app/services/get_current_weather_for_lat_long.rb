#
# Input:
#   context.lat: Float
#   context.long: Float
#
# Output:
#   context.weather_poro: WeatherPoro
#

class GetCurrentWeatherForLatLong
  include Interactor

  delegate :lat, :long, :response, :weather_poro, :is_cached, to: :context

  def call
    validate_coordinates
    get_current_weather_for_lat_long_from_open_weather
    validate_response
    fail_with_could_not_create_weather_poro unless create_weather_poro
  end

  private

  def validate_response
    fail_with_bad_request unless response.status == 200
    fail_with_bad_response unless response.body
  end

  def validate_coordinates
    fail_with_bad_coordinates unless lat.class == Float && long.class == Float
  end

  def create_weather_poro
    body = response.body

    context.weather_poro = WeatherPoro.new(
      body["weather"][0]["main"],
      body["weather"][0]["description"],
      body["main"]["temp"],
      body["main"]["feels_like"],
      body["main"]["humidity"]
    ) rescue nil
  end

  def fail_with_bad_request
    context.fail!(error_message: 'Invalid response from weather service')
  end

  def fail_with_bad_coordinates
    context.fail!(error_message: 'Invalid class type of lat and/or long')
  end

  def fail_with_bad_response
    context.fail!(error_message: 'Failed to get weather attributes from lat/long')
  end

  def fail_with_could_not_create_weather_poro
    context.fail!(error_message: 'Failed to create weather poro')
  end

  def get_current_weather_for_lat_long_from_open_weather
    cache_key = "open_weather/current_weather/#{lat}/#{long}"
    context.is_cached = Rails.cache.instance_variable_get(:@data).keys.include?(cache_key)
    context.response = Rails.cache.fetch cache_key, expires_in: 30.minutes do
      open_weather_service.get_current_weather_for_lat_long(lat, long)
    end
  end

  def open_weather_service
    External::OpenWeatherService.new
  end
end