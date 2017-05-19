# Description:
#   Provides push notifications to the scorecentre stage app
#
# Commands:
#   hubot scorecentre notifications help - provides additional info for producing notifications
#   hubot android random scorecentre notification - produces a random notification targetting android devices.
#   hubot android scorecentre notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot android blank scorecentre notification - produces a notification with no story_id
#   hubot ios random scorecentre notification - produces a random notification targetting ios devices.
#   hubot ios scorecentre notification story_id notification_text - produces a notification for the provided story_id with custom notification_text (notification_text optional)
#   hubot ios blank scorecentre notification - produces a notification with no story_id

postData = JSON.stringify({
  'audience' : 'all',
  'device_types' : ['<<platform>>'],
  'notification' : {
    'alert' : '<<title>>',
    '<<platform>>' : {
      'extra' : {
        'id' : '<<article_id>>',
        't' : 1,
        's' : 1,
        'e' : 6,
        'p' : 0,
        'd' : 'QwOTJiNTE65DgQESIIZNrIDx5jCKgQyf'
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
  ['9913873', 'probably some footy news']
]

URBAN_AIRSHIP_AUTH = process.env.HUBOT_SCORECENTRE_URBAN_AIRSHIP_AUTH

module.exports = (robot) ->
  robot.respond /android random scorecentre notification/i, (msg) ->
    story_deets = msg.random ARTICLE_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android scorecentre notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    article_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('android').split(ID_VAR).join(article_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /android blank scorecentre notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('android').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios random scorecentre notification/i, (msg) ->
    story_deets = msg.random ARTICLE_IDS
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(story_deets[0]).split(TITLE_VAR).join(story_deets[1])) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios scorecentre notification (.*)/i, (msg) ->
    data = msg.match[1].split(" ")
    article_id = data[0]
    title = if (data.length > 1) then data.slice(1).join(" ") else "Message"
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(postData.split(PLATFORM_VAR).join('ios').split(ID_VAR).join(article_id).split(TITLE_VAR).join(title)) (err, res, body) ->
      msg.send "Sent"

  robot.respond /ios blank scorecentre notification/i, (msg) ->
    robot.http('https://go.urbanairship.com/api/push')
    .header('Accept', 'application/vnd.urbanairship+json; version=3')
    .header('Content-Type', 'application/x-www-form-urlencoded')
    .header('Authorization', "Basic #{URBAN_AIRSHIP_AUTH}")
    .post(noStoryPostData.split(PLATFORM_VAR).join('ios').split(TITLE_VAR).join('this story has no id')) (err, res, body) ->
      msg.send "Sent"

  robot.respond /scorecentre notifications help/i, (msg) ->
    message = []
    message.push 'I can produce push notifications to stage apps for you!'
    message.push 'Here\'s how:'
    message.push ''
    message.push robot.name + ' android random scorecentre notification - I\'ll send a random notification from a hard coded list.'
    message.push robot.name + ' android scorecentre notification (article_id) - I\'ll send a notification of the provided story_id (replace (article_id) including brackets).'
    message.push robot.name + ' android scorecentre notification (article_id) (message) - same as above, but with a custom notification message.'
    message.push robot.name + ' android blank scorecentre notification - I\'ll send a notification with no article and set message.'
    message.push robot.name + ' ios random scorecentre notification - I\'ll send a random notification from a hard coded list.'
    message.push robot.name + ' ios scorecentre notification (article_id) - I\'ll send a notification of the provided story_id (replace (article_id) including brackets).'
    message.push robot.name + ' ios scorecentre notification (article_id) (message) - same as above, but with a custom notification message.'
    message.push robot.name + ' ios blank scorecentre notification - I\'ll send a notification with no article and set message.'
    msg.send message.join('\n')
