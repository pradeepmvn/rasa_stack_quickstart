var express = require('express');
var YQL = require('yql');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.json({ title: 'Express' });
});

router.post('/', function(req, res, next) {
  //get the action from body
  if(typeof req.body.next_action =='undefined' || req.body.next_action== ''){
    res.status(500).send('Internal Error. Next Action(next_action) not found or empty!');
    return;
  }
  console.log("next: " + JSON.stringify(req.body));
  req.url = req.url+req.body.next_action;
  console.log(req.url);
  next('route');
});

/* GET Weather home page. */
router.post('/utter_webhook_current_weather', function(req, res, next) {
  console.log("utter_webhook_current_weather");
  var slots =req.body.tracker.slots;
  var query = new YQL('select * from weather.forecast where woeid in (select woeid from geo.places(1) where text="'+slots.city+'")');
  query.exec(function(err, data) {
    var location = data.query.results.channel.location;
    var condition = data.query.results.channel.item.condition;
    var msg2send ='The current weather in ' + location.city + ', ' + location.region + ' is ' + condition.temp + ' degrees and it is ' +condition.text;
    console.log(msg2send);
    res.json({speech: "",displayText: msg2send,dataToClient:{}});
  });
});

/* GET Weather home page. */
router.post('/utter_webhook_forecast_5day', function(req, res, next) {
  console.log("utter_webhook_forecast_5day");
  var slots =req.body.tracker.slots;
  var query = new YQL('select * from weather.forecast where woeid in (select woeid from geo.places(1) where text="'+slots.city+'")');
  query.exec(function(err, data) {
    var location = data.query.results.channel.location;
    var condition = data.query.results.channel.item.condition;
    var msg2send = 'The current weather in ' + location.city + ', ' + location.region + ' is ' + condition.temp + ' degrees.';
    console.log(msg2send);
    res.json({speech: "",displayText: msg2send,dataToClient:{}});
  });
});

/* returns wind speed(mph), wind chill and wind direction. */
router.post('/utter_webhook_forecast_wind', function(req, res, next) {
  console.log("utter_webhook_forecast_wind");
  var slots =req.body.tracker.slots;
  var query = new YQL('select * from weather.forecast where woeid in (select woeid from geo.places(1) where text="'+slots.city+'")');
  query.exec(function(err, data) {
    var location = data.query.results.channel.location;
    var wind = data.query.results.channel.wind;
    var condition = data.query.results.channel.item.condition;
    var msg2send = 'Wind speed is : ' + wind.speed;
    console.log(msg2send);
    res.json({speech: "",displayText: msg2send,dataToClient:{}});
  });
});

module.exports = router;
