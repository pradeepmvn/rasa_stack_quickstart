## Weather chatbot

This starts a container with rasa core , rasa nlu and executes a weather chatbot on top of Yahoo Weather Query Language.

### Installation
All the content/ data is prepackaged and loaded into the containers. So the installation steps are very simple.

Pre-Requisites: ```docker-compose```

```
git clone https://github.com/pradeepmvn/rasa_stack_quickstart.git
cd weatherBot
docker-compose up
Browse to http://localhost:5001/ to train the NLU and view the training data.
Browse to http://localhost:5001/bot-demo/ for chatbot Demo
```


This will install 5 containers in the below fashion
- Rasa ui for administration and testing. This includes postgres db and bot-demo as well.
- rasa nlu for NLU
- rasa core for dialogue management
- weatherbot-api (REST) for weather API interactions with Yahoo


Credits:

- https://github.com/JustinaPetr/Weatherbot_Tutorial
- Yahoo Weather API

#### Cleanup docker storage

```
docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
```

## Load Custom Rasa Models into Rasa-UI and the Web Demo

The weatherbot is a good example in order to learn how a bot works and how to use API calls, but most likely you will want to replace this bot with one of your own. These are the instructions to do so.

Prerequisites: Assure that docker-compose up runs with no errors and that the weatherbot at /bot-demo works as intended

### Before Building The Containers

Before you build the containers with docker-compose up --build you will need to replace some information in some of the files of the repo.

The first of these are in the weatherbot/rasa_core folder. The files in this folder hold the required data for Rasa Core (as opposed to Rasa NLU). This data must be stored here and deployed before the rest of the docker containers because currently Rasa UI doesn't support Rasa Core training and data storage in PostgreSQL. The intents, stories, actions, and entities here must match the ones you train your Rasa NLU model with in Rasa UI.


#### weatherbot/rasa_core/data/domain.yml

Fully replace the contents of this file with your domain.yml file, or use the sample domain.yml code below if you want to confirm functionality before committing to using your model.

```
intents:
  - greet
  - help
action_factory: remote
actions:
  - utter_greet
  - utter_help
templates:
  utter_greet:
    - text: Hello human!
  utter_help:
    - text: Human, how can I help you?
```

#### weatherbot/rasa_core/data/stories.md

Now do the same for the stories.md file. Here is the corresponding sample file.

```
## story1
* greet
  - utter_greet
* help
  - utter_help

## story2
* greet
  - utter_greet

## story3
* help
  - utter_help
```

#### weatherbot/rasa-ui/weather-insert.sql

You have a few options here. This is where the data that Rasa NLU will use to train is inserted into the PostgreSQL database. The code supplied below contains the bare minimum you need in order to get everything to work, and you will have to manually add your responses into Rasa UI. Whenever you rebuild, you will have to enter this information again unless you automate it by using more SQL queries. But for now, this is the bare minimum you need to get things running.

```
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;


INSERT INTO agents (agent_id, agent_name, endpoint_enabled, rasa_core_enabled, endpoint_url, basic_auth_username, basic_auth_password, client_secret_key, story_details) VALUES (4, 'LBot', true, true, 'http://weatherbot-api:5002/', NULL, NULL, '8ba60abbaa7d20d65bcfb6a15b4d38ec', '## story1
* greet
  - utter_greet
* help
  - utter_help

## story2
* greet
  - utter_greet

## story3
* help
  - utter_help');

INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_help', 4, 31);
INSERT INTO actions (action_name, agent_id, action_id) VALUES ('utter_greet', 4, 32);

INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('greet', 4, NULL, 28);
INSERT INTO intents (intent_name, agent_id, endpoint_enabled, intent_id) VALUES ('help', 4, NULL, 29);

INSERT INTO settings (setting_name, setting_value) VALUES ('refresh_time', '-1');

```

#### Optional Steps

These steps are optional, but if you want to name your bot/agent something other than "WeatherBot" you will have to change the string instance in these 5 locations:

```
docker-compose.yml
rasa_nlu/nlu-config.yml
rasa-ui/bot-demo/index.html (2 instances)
rasa-ui/weather-insert.sql
```


### After Building The Containers

Run docker-compose up --build to rebuild all of the containers with your changes.

Navigate to http://localhost:5001/ and you should see your Agent loaded in with two intents, two actions, and three stories. You will need to open up the intents and actions to add your responses. Click on them and add responses similar to the following.

![Screenshot1](https://i.imgur.com/M6kBlhz.png)
![Screenshot1](https://i.imgur.com/NflbDOE.png)

Now on the Agent page, it should look something like this:

![Screenshot1](https://i.imgur.com/sxVbImN.png)

Now go to the Training page, train your bot, and navigate to
You should be able to replicate similar messages as below: http://localhost:5001/bot-demo/

![Screenshot1](https://i.imgur.com/eSspnE5.png)

If you check your terminal you should see all of the debugging information as well! You can also customize the CSS of the bot to your heart's desire.

Happy botting!
