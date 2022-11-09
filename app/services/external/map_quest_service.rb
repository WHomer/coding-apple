class External::MapQuestService
  URL = "http://www.mapquestapi.com"

  def get_latlong_for_address(address)
    path = "/geocoding/v1/address"

    response(path, {location: address})
  end

  private

  def conn
    Faraday.new(URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.response :json # decode response bodies as JSON
      f.adapter :net_http # adds the adapter to the connection, defaults to `Faraday.default_adapter`
      f.params[:key] = ENV["map_quest_key"]
    end
  end

  def response(path, params)
    response = conn.get(path) do |req|
      req.params.merge! params
    end
  end

end