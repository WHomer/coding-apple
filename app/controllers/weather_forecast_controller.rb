class WeatherForecastController < ApplicationController

  def index
    @coordinates = GetLatLongForAddress.call(search_params) if search_params
    @weather = GetCurrentWeatherForLatLong.call(lat: @coordinates.lat, long:@coordinates.long) if @coordinates.success?
  end

  private

  def search_params
    params.permit(:address)
  end
end