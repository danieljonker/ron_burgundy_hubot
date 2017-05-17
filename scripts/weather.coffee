# Description:
#   Provides forecast based on search criteria
#
# Commands:
#   hubot forecast (search string) - provides forecast for searched area

OPEN_WEATHER_API_KEY = "91b9b78861116f95facbc935907c6ae5";
UNIT = "metric";

module.exports = (robot) ->
  robot.respond /forecast (.*)/i, (msg) ->
    data = msg.match[1]
    robot.http("http://api.openweathermap.org/data/2.5/weather?q=#{data}&units=#{UNIT}&appid=#{OPEN_WEATHER_API_KEY}")
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .get() (err, res, body) ->
        jsonResponse = JSON.parse body
        description = jsonResponse.weather[0].description
        currentTemp = jsonResponse.main.temp
        minTemp = jsonResponse.main.temp_min
        maxTemp = jsonResponse.main.temp_max
        msg.send "The Weather forecast for today is: #{description} & the current temp is: #{currentTemp}°C \n min temp #{minTemp}°C \n max temp #{maxTemp}°C"
