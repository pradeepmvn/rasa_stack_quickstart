FROM paschmann/rasa-ui:latest

ADD bot-demo /opt/rasaui/web/src/bot-demo
COPY weather-insert.sql /opt/postgresql/

# Install weather Agent Scripts.
WORKDIR /opt/postgresql

RUN service postgresql start && su postgres -c " echo \"\c rasaui; \i weather-insert.sql\" | psql && echo \"grant all on database rasaui to rasaui; grant all privileges on all tables in schema public to rasaui; grant all privileges on all sequences in schema public to rasaui \"|psql rasaui" && service postgresql stop
WORKDIR /opt/rasaui
