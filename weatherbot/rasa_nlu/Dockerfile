FROM rasa/rasa_nlu:0.12.3-full

RUN pip install --upgrade pip

WORKDIR ${RASA_NLU_HOME}

COPY nlu-config.yml ${RASA_NLU_HOME}/config.yml

RUN mkdir /app/projects

#Needed this for python program to write models
RUN chmod -R 777 /app

CMD ["start", "-c", "config.yml", "--path", "/app/projects"]
