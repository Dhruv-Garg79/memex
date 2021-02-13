FROM node:12.20.1-alpine3.9
RUN mkdir /xmeme
ADD /backend /xmeme
WORKDIR /xmeme
RUN npm install
EXPOSE 8081
ENTRYPOINT ["npm", "run", "start_dev"]

