FROM alpine

ENV LIQUIBASE_VERSION 4.3.5
ENV MYSQL_CONNECTOR_VERSION 8.0.11

RUN apk add --update bash tzdata curl openjdk8-jre && rm -rf /var/cache/apk/*

ENV PATH $PATH:/liquibase

RUN mkdir -p /liquibase && \
    curl -L https://github.com/liquibase/liquibase/releases/download/v$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION.tar.gz | tar xzC /liquibase

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz  | tar xzC /liquibase/lib
RUN cp /liquibase/lib/mysql-connector-java-$MYSQL_CONNECTOR_VERSION/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.jar /liquibase/lib && rm -rf /liquibase/lib/mysql-connector-java-$MYSQL_CONNECTOR_VERSION

RUN apk add --no-cache python3 py3-pip bash \
    && pip3 install --upgrade pip  && pip3 install awscli && rm -rf /var/cache/apk/*

RUN apk update && apk add mysql-client

RUN apk update && apk add busybox-extras

# RUN liquibase --version
# WORKDIR /code

# COPY . /code

ENTRYPOINT ["/bin/sh"]