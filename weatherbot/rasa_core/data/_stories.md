## story 1
* greet_intent
  - utter_greet
  - utter_how_to_help
* current_weather{"city": "atlanta"}
  - slot{"city": "atlanta"}
  - utter_webhook_current_weather
  - utter_anythingelse
* no
  - utter_thanks
  - action_restart

## story 2
* greet_intent
  - utter_greet
  - utter_how_to_help
* current_weather
  - utter_ask_city
* city_slot_info{"city": "atlanta"}
  - slot{"city": "atlanta"}
  - utter_webhook_current_weather
  - utter_anythingelse
* yes
  - utter_how_to_help
* 5day_forecast
	- utter_webhook_forecast_5day
* wind_speed
	- utter_webhook_forecast_wind
	- utter_anythingelse
* no
  - utter_thanks
  - action_restart

## story 3
* greet_intent
  - utter_greet
  - utter_how_to_help
* 5day_forecast{"city": "atlanta"}
  - slot{"city": "atlanta"}
	- utter_webhook_forecast_5day
* wind_speed
	- utter_webhook_forecast_wind
	- utter_anythingelse
* no
  - utter_thanks
  - action_restart
