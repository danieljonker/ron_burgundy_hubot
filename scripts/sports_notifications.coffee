# Description:
#   Provides push notifications to the sports stage apps
#
# Commands:
#   hubot notifications help - provides additional info for producing notifications
#   hubot android random sports notification - produces a random notification targetting android devices.
#   hubot android sports notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot android blank sports notification - produces a notification with no story_id
#   hubot ios random sports notification - produces a random notification targetting ios devices.
#   hubot ios sports notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot ios blank sports notification - produces a notification with no story_id

postData = JSON.stringify({
  'audience' : 'all',
  'device_types' : ['<<platform>>'],
  'notification' : {
    'alert' : '<<title>>',
    '<<platform>>' : {
      'extra' : {
        'article_id' : '<<article_id>>',
        'type_id' : 1
        }
      }
    }
  })

noStoryPostData = JSON.stringify({
  'audience' : 'all',
  'device_types' : ['<<platform>>'],
  'notification' : {
    'alert' : '<<title>>',
    }
  })

PLATFORM_VAR = '<<platform>>'
TITLE_VAR = '<<title>>'
ID_VAR = '<<article_id>>'
# Todo: change the below array items
ARTICLE_IDS = [
  ['9913873', 'heard u like shoes brah']
]

URBAN_AIRSHIP_AUTH = process.env.HUBOT_SPORTS_URBAN_AIRSHIP_AUTH

module.exports = (robot) ->
  robot.respond /android random sports notification/i, (msg) ->
    story_deets = msg.random ARTICLE_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android sports notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    article_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(article_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android blank sports notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('android').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios random sports notification/i, (msg) ->
    story_deets = msg.random ARTICLE_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios sports notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    article_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(article_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios blank sports notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('ios').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /sports notifications help/i, (msg) ->
    message = []
    message.push 'I can produce push notifications to stage apps for you!'
    message.push 'Here\'s how:'
    message.push ''
    message.push robot.name + ' android random sports notification - I\'ll send a random notification from a hard coded list.'
    message.push robot.name + ' android sports notification (article_id) - I\'ll send a notification of the provided story_id (replace (article_id) including brackets).'
    message.push robot.name + ' android sports notification (article_id) (message) - same as above, but with a custom notification message.'
    msg.send message.join('\n')
