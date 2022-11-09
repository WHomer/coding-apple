class External::OpenWeatherService
  URL = "https://api.openweathermap.org"

  def get_current_weather_for_lat_long(lat, long)
    path = "/data/2.5/weather"
    params = {units: "imperial", lat: lat, lon: long}

    response(path, params)
  end

  private

  def conn
    Faraday.new(URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.response :json # decode response bodies as JSON
      f.adapter :net_http # adds the adapter to the connection, defaults to `Faraday.default_adapter`
      f.params[:appid] = ENV["open_weather_key"]
    end
  end

  def response(path, params)
    response = conn.get(path) do |req|
      req.params.merge! params
    end
  end
end
