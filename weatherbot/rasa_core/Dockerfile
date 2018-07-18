FROM python:3.5

RUN apt-get update && apt-get install -y \
    software-properties-common
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip

RUN mkdir /app
ADD /data /data
RUN chmod -R 777 /data

WORKDIR /app
#RUN pip install rasa_core

#Uses Latest Rasa Core.
RUN git clone -b 0.9.0a3 https://github.com/RasaHQ/rasa_core.git
RUN python -m pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.8.0-cp35-cp35m-linux_x86_64.whl
WORKDIR /app/rasa_core
RUN pip install -r requirements.txt
RUN pip install -e .

WORKDIR /data

EXPOSE 5005
ENTRYPOINT ["./entrypoint.sh"]
