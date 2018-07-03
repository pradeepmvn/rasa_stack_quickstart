--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.15
-- Dumped by pg_dump version 10.1

-- Started on 2018-06-28 14:45:31 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 3134 (class 0 OID 26980)
-- Dependencies: 179
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO agents (agent_id, agent_name, endpoint_enabled, rasa_core_enabled, endpoint_url, basic_auth_username, basic_auth_password, client_secret_key, story_details) VALUES (4, 'WeatherBot', true, true, 'http://weatherbot-api:5002/', NULL, NULL, '8af54c0bf30bc6cbbf70a3f8fb6348e4', '## story 1
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
  - action_restart');

--
-- TOC entry 3129 (class 0 OID 26951)
-- Dependencies: 174
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_webhook_current_weather', 4, 28);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_webhook_forecast_5day', 4, 29);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_webhook_forecast_wind', 4, 30);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_how_to_help', 4, 31);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_greet', 4, 32);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_anythingelse', 4, 33);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_ask_city', 4, 34);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_thanks', 4, 35);

--
-- TOC entry 3137 (class 0 OID 27010)
-- Dependencies: 184
-- Data for Name: entities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entities (entity_id, entity_name, agent_id, slot_data_type) VALUES (7, 'city', 4, 'text');

--
-- TOC entry 3144 (class 0 OID 27044)
-- Dependencies: 192
-- Data for Name: expressions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'whats the current weather in atlanta', 165);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'how is the weather now in New york', 166);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'whats the weather now', 167);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'how is the weather now', 168);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'is it sunny now', 169);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (26, 'how hot is it now', 170);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (27, 'New york', 171);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (27, 'Atlanta', 172);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (27, 'Raleigh', 173);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (27, 'Greenville', 174);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (28, 'hi', 175);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (28, 'hello', 176);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (28, 'hi there !!', 177);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (28, 'what can you do', 178);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (28, 'how are you', 179);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (29, 'yeah', 180);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (29, 'yes', 181);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (29, 'sure', 182);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (30, 'no', 183);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (30, 'naah', 184);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (30, 'not now', 185);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (32, 'how about wind speed?', 186);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (32, 'what is the wind speed', 187);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (32, 'what about wind speed', 188);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (32, 'metrics on wind', 189);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (33, 'what is the forecast', 190);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (33, 'how is the 5 day forecast', 191);
INSERT INTO expressions (intent_id, expression_text, expression_id) VALUES (33, 'can you tell me the 5 day forecast', 192);

--
-- TOC entry 3152 (class 0 OID 27088)
-- Dependencies: 203
-- Data for Name: intents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('current_weather', 4, NULL, 26);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('city_slot_info', 4, NULL, 27);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('greet_intent', 4, NULL, 28);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('no', 4, NULL, 30);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('wind_speed', 4, NULL, 32);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('yes', 4, NULL, 29);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('5day_forecast', 4, NULL, 33);




--
-- TOC entry 3146 (class 0 OID 27053)
-- Dependencies: 194
-- Data for Name: parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'atlanta', 165, 29, 36, 7, 164);
INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'New york ', 166, -1, 8, 7, 165);
INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'Greenville', 174, 0, 10, 7, 166);
INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'Raleigh', 173, 0, 7, 7, 167);
INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'Atlanta', 172, 0, 7, 7, 168);
INSERT INTO parameters (parameter_required, parameter_value, expression_id, parameter_start, parameter_end, entity_id, parameter_id) VALUES (NULL, 'New york', 171, 0, 8, 7, 169);


--
-- TOC entry 3155 (class 0 OID 27104)
-- Dependencies: 206
-- Data for Name: regex; Type: TABLE DATA; Schema: public; Owner: postgres
--
--
-- TOC entry 3160 (class 0 OID 27128)
-- Dependencies: 212
-- Data for Name: responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (175, NULL, 34, NULL, NULL, 'ok Great! what location are you interested in?', 1);
INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (176, NULL, 31, '[{"seq": 0, "title": "Current Weather", "payload": "/current_weather", "$$hashKey": "object:464"}, {"seq": 1, "title": "Wind Speed", "payload": "/wind_speed", "$$hashKey": "object:466"}, {"seq": 2, "title": "Forecast", "payload": "/5day_forecast", "$$hashKey": "object:468"}]', NULL, 'Iam trained about general weather questions. Feel free to try the following:', 1);
INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (177, NULL, 32, NULL, NULL, 'hello there!!', 1);
INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (178, NULL, 32, NULL, NULL, 'hi. Welcome to Weather Bot!', 1);
INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (179, NULL, 33, NULL, NULL, 'Would you like to try anything else?', 1);
INSERT INTO responses (response_id, intent_id, action_id, buttons_info, response_image_url, response_text, response_type) VALUES (180, NULL, 35, NULL, NULL, 'Thanks for using Weather Bot!!', 1);
--
-- TOC entry 3161 (class 0 OID 27135)
-- Dependencies: 213
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO settings (setting_name, setting_value) VALUES ('refresh_time', '-1');


-- Completed on 2018-06-28 14:45:47 EDT

--
-- PostgreSQL database dump complete
--
