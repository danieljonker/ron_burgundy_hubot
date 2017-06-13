module.exports = (robot) ->

  robot.hear /badger/i, (res) ->
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

  robot.hear /.*(appium).*/i, (msg) ->
    msg.send msg.random crappium
    
   ronbot.hear /.*(shakir).*/i, (msg) ->
    msg.send "/giphy chaka khan"

  robot.respond /pong/i, (msg) ->
    msg.send 'PING'

crappium = [
    ":poop:ium",
    "*CRAPPIUM*",
    "More like crappium :smirk:"
  ]
