#!/bin/bash
set -e

#execute the training
python -m rasa_core.train -s /data/_stories.md -d /data/_domain.yml -o /data/models/dialogue


#start Rasa core server with NLU as a separate server
python -m rasa_server -d /data/models/dialogue -u RasaNLUHttpInterpreter --cors '*'
