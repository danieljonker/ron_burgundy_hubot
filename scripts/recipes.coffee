# Description:
#   Provides recipes based on search criteria
#
# Commands:
#   hubot recipe (search string) - provides a random recipe based on the search string

FOOD_TO_FORK_API_KEY = process.env.HUBOT_FOOD_TO_FORK_API_KEY
FOOD_TO_FORK_URL = "http://food2fork.com/api/search?key=d875c0c6187cc9fadd3b4cdde6fae509&q=veg%20pasta"

module.exports = (robot) ->
  robot.respond /recipe (.*)/i, (msg) ->
    data = msg.match[1]
    robot.http("http://food2fork.com/api/search?key=#{FOOD_TO_FORK_API_KEY}&q=#{data}")
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .get() (err, res, body) ->
      try
        jsonResponse = JSON.parse body
      catch error
       msg.send "Ran into an error parsing JSON :("
       return
      randomRecipe = msg.random jsonResponse.recipes
      msg.send "Recipe: #{randomRecipe.source_url}"
