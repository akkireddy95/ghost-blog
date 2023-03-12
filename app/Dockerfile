FROM ghost:4-alpine

RUN apk add --no-cache mysql-client bash

COPY config.production.json /var/lib/ghost/config.production.json

ENV NODE_ENV=production \
    url=http://localhost:8080 \
    database__client=mysql \
    database__connection__host=db \
    database__connection__user=root \
    database__connection__password=example \
    database__connection__database=ghost

EXPOSE 2368

CMD ["npm", "start", "--production"]
