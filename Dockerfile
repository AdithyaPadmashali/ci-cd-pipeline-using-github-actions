# FROM node:10-alpine 
# # as build-step

# RUN mkdir /app

# WORKDIR /app

# COPY package.json /app

# RUN npm install

# COPY . /app
# CMD ["npm","start"]  
# # RUN npm run build
# # # CMD node /app/src/index.js --bind 0.0.0.0:$PORT

# # #  Stage 2

# # FROM nginx:1.17.1-alpine

# # COPY --from=build-step /app/build /usr/share/nginx/html
# # # COPY nginx.conf /etc/nginx/conf.d/default.conf
# # # CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
FROM node:lts

# First of all, only copy package.json
# along with its lockfile into /code.
COPY package.json /code/
COPY package-lock.json  /code/

# Download all dependencies listed
# in package.json.
RUN npm ci

# If the dependencies haven't been
# changed, the cache is used at least
# up to now. Copy the source files.
COPY src /code/src

# Start the application.
CMD ["npm", "start"]