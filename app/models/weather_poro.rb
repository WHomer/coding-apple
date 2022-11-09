class WeatherPoro
  attr_reader :condition,
              :description,
              :temp,
              :feels_like,
              :humidity

  def initialize(condition, description, temp, feels_like, humidity)
    @condition = condition
    @description = description
    @temp = temp
    @feels_like = feels_like
    @humidity = humidity
  end
end