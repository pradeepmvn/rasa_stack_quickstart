FROM node:boron

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json ./
RUN npm install

# Bundle app source
COPY . .

WORKDIR /usr/src/app

EXPOSE 8082
RUN chmod 777 entrypoint.sh
CMD [ "npm", "start" ]
#ENTRYPOINT ["./entrypoint.sh"]
