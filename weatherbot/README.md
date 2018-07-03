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
