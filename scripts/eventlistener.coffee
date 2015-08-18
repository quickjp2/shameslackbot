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
    data = JSON.parse(event.data)
    robot.logger.info "This is the data we got...#{data}"
    robot.logger.info "This is the event type...#{event.type}"
    robot.logger.info "The core ID is -#{data.coreid}- and it's data is -#{data.data}"
    robot.http("https://docs.google.com/forms/d/19QqJDceRyWT9zXypb_9ManeAI4qGDemjuTNEv0-cNW4/viewform")
      .post("entry.571261089=#{data.coreid}&entry.1060543689=#{data.data}") (err, res, body) ->
        if err
          robot.logger.info "Encountered an error: #{err}"
          return
        else
          robot.logger.info "We got back success!"
    return
  ), false
