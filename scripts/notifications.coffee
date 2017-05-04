# Description:
#   Provides push notifications to the news stage apps
#
# Commands:
#   hubot notifications help - provides additional info for producing notifications
#   hubot android random notification - produces a random notification targetting android devices.
#   hubot android notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot android blank notification - produces a notification with no story_id
#   hubot ios random notification - produces a random notification targetting ios devices.
#   hubot ios notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot ios blank notification - produces a notification with no story_id

postData = JSON.stringify({
  'audience' : 'all',
  'device_types' : ['<<platform>>'],
  'notification' : {
    'alert' : '<<title>>',
    '<<platform>>' : {
      'extra' : {
        'id' : '<<story_id>>',
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
ID_VAR = '<<story_id>>'
STORY_IDS = [
  ['9925882', 'heard u like shoes brah'],
  ['9904673', 'Brexit deal must clarify Ireland border poll commitment'],
  ['9904360', 'Vauxhall and Opel sold to Peugeot owner PSA in £1.9bn']
]

URBAN_AIRSHIP_AUTH = process.env.HUBOT_URBAN_AIRSHIP_AUTH

module.exports = (robot) ->
  robot.respond /android random notification/i, (msg) ->
    story_deets = msg.random STORY_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    story_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(story_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android blank notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('android').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios random notification/i, (msg) ->
    story_deets = msg.random STORY_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    story_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(story_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios blank notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('ios').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /notifications help/i, (msg) ->
    message = []
    message.push 'I can produce push notifications to stage apps for you!'
    message.push 'Here\'s how:'
    message.push ''
    message.push robot.name + ' android random notification - I\'ll send a random notification from a hard coded list.'
    message.push robot.name + ' android notification (story_id) - I\'ll send a notification of the provided story_id (replace (story_id) including brackets).'
    message.push robot.name + ' android notification (story_id) (message) - same as above, but with a custom notification message.'
    msg.send message.join('\n')
