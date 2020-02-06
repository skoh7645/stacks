# Install the app dependencies in a full Node docker image
FROM node:12

# Install OS updates
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies' \
 && useradd --gid 0 --create-home node_user

# Install stack dependencies
WORKDIR /project
COPY ./package*.json ./
RUN npm install

# Install user-app dependencies
WORKDIR /project/user-app
COPY ./user-app/package*.json ./

# RUN `npm install` instead of `npm install --production` as we need to transpile TS code
RUN npm install
WORKDIR /project/user-app/node_modules

# Copy the dependencies into a slim Node docker image
FROM node:12-slim

# Install OS updates
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies'

# Copy the project
COPY . /project

# Copy all dependencies
COPY --from=0 /project/node_modules /project/node_modules
COPY --from=0 /project/user-app/node_modules /project/user-app/node_modules

WORKDIR /project

# Make sure TypeScript source code is transpiled
RUN npm run build \
 && npm run build --prefix user-app \
 && chown -R node:0 /project \
 && chmod -R g=u /project 

ENV NODE_ENV production
ENV PORT 3000

USER node

CMD ["npm", "start"]