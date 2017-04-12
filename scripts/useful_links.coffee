# Description:
#   Provides work related stuff
#
# Commands:
#   hubot ios config - Reply with URL for iPhone config
#   hubot android config - Reply with URL for Android config
#   hubot jira url - Reply with URL for jira
#   hubot confluence url - Reply with URL for jira
#   hubot android signing server - Reply with android signing server url
#   hubot omniture url - Reply with the link to omniture
#   hubot urban airship - Reply with the link to Urban Airhship

module.exports = (robot) ->
  robot.respond /ios config/i, (msg) ->
    msg.send "http://app.news.sky.com/ios/config.json"

  robot.respond /android config/i, (msg) ->
    msg.send "http://app.news.sky.com/android/config.json"

  robot.respond /jira url/i, (msg) ->
    msg.send "https://developer.bskyb.com/jira/secure/RapidBoard.jspa?rapidView=377&view=detail"

  robot.respond /confluence url/i, (msg) ->
    msg.send "https://developer.bskyb.com/wiki/display/SSDM/Sky+News+Mobile+App"

  robot.respond /android signing server/i, (msg) ->
    msg.send "http://node075.app.sit.ost.imp.bskyb.com:8080/login?from=%2Fjob%2FAndroid%2520Signing%2520Task%2Fbuild%3Fdelay%3D0sec"

  robot.respond /omniture url/i, (msg) ->
    msg.send "https://sc.omniture.com/login/?r=%2Fsc15%2Freports%2Findex.html%3Fa%3DOverview.Recommended%26ssSession%3Daf315f3a3515e01bccf1901451366c4c%26jpj%3D34497421106134"

  robot.respond /urban airship/i, (msg) ->
    msg.send "https://go.urbanairship.com/apps/"

  robot.respond /gitlab/i, (msg) ->
    msg.send "https://git.bskyb.com/groups/newsmob/"

  robot.respond /who(.*)s fault is it(.*)(.*)$/i, (msg) ->
    msg.send "It's Jamie's fault!"
