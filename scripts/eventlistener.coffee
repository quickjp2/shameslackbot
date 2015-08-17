EventSource = require 'eventsource'
http = require 'http'
QS = require 'querystring'
url = require 'url'
data = ""
addr = "https://api.particle.io/v1/events" 

module.exports = (robot) ->
  eventSourceInitDict = 
    rejectUnauthorized: false
    headers: 'Authorization': 'Bearer 33d2f312a176dcc1ec87f069be6f8ef3bd0ec1cc'
  es = new EventSource(addr.toString(), eventSourceInitDict)
  es.addEventListener 'notifyr/announce', ((event) ->
    #Function code goes here
    data = JSON.stringify(event.data)
    robot.logger.info "This is the data we got...#{data}"
    robot.logger.info "This is the event type...#{event.type}"
    robot.http("https://docs.google.com/forms/d/1bfiRlVXgWZ3tBGWH4jZWrs__4u0CxiGqZNqxKfRANt8/formResponse")
      .post("entry_436001820=#{data.coreid}&entry_124394131=#{data.data}") (err, res, body) ->
        if err
          robot.logger.info "Encountered an error: #{err}"
          return
        else
          robot.logger.info "We got back: #{body}"
    return
  ), false
