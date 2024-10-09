class WeatherService
  def self.fetch_weather(location)
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{ENV['OPENWEATHER_API_KEY']}")
    info = JSON.parse(response.body)
    {
      temperature: info['main']['temp'],
      humidity: info['main']['humidity'],
      wind_speed: info['wind']['speed'],
      weather_description: info['weather'][0]['description'],
      weather_title: info['weather'][0]['main']
    }
  end
end
