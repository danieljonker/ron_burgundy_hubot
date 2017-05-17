# Description:
#   Provides random gif
#
# Commands:
#   hubot random gif - provides random gif

GIPHY_API_KEY = process.env.HUBOT_GIPHY_API_KEY;

module.exports = (robot) ->
  robot.respond /random gif/i, (msg) ->
    robot.http("http://api.giphy.com/v1/gifs/random?&api_key=#{GIPHY_API_KEY}")
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .get() (err, res, body) ->
        jsonResponse = JSON.parse body
        gifs = jsonResponse.data.url
        msg.send "#{gifs}"

  robot.respond /gif (.*)/i, (msg) ->
    data = msg.match[1]
    robot.http("http://api.giphy.com/v1/gifs/search?q=#{data}&api_key=#{GIPHY_API_KEY}")
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .get() (err, res, body) ->
        jsonResponse = JSON.parse body
        searchedGif = msg.random jsonResponse.data
        url = searchedGif.images.fixed_height.url
        msg.send "#{url}"
