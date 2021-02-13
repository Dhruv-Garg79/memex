FROM node:12.20.1-alpine3.9
WORKDIR /backend
COPY ..
RUN npm install
EXPOSE 8081
ENTRYPOINT ["npm", "run", "start"]

https://medium.com/faun/step-by-step-guide-to-dockerize-a-node-js-express-application-cb6be4159cf1
