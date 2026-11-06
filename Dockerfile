FROM node:lts-alpine AS builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- all the stuff we care in production

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# don't need t specify the default command since nginx image's default command is to run that