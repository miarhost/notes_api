FROM mongo:latest
WORKDIR /
ENV MONGO_INITDB_ROOT_USERNAME admin-user
ENV MONGO_INITDB_ROOT_PASSWORD admin-password
ENV MONGO_INITDB_DATABASE admin

ADD ./app/docker/mongo/mongo-init.js /docker-entrypoint-initdb.d/

CMD ["mongod"]
EXPOSE 20217
