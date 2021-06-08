FROM alpine

ENV LIQUIBASE_VERSION 4.3.5
ENV MYSQL_CONNECTOR_VERSION 8.0.25

RUN apk add --update bash tzdata curl openjdk8-jre && rm -rf /var/cache/apk/*

ENV PATH $PATH:/liquibase

RUN mkdir -p /liquibase && \
    curl -L https://github.com/liquibase/liquibase/releases/download/v$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION.tar.gz | tar xzC /liquibase
    
RUN curl -L -o /liquibase/lib/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.tar.gz

RUN apk add --no-cache python3 py3-pip bash \
    && pip3 install --upgrade pip  && pip3 install awscli && rm -rf /var/cache/apk/*

RUN liquibase --version

RUN AWS --version

ENTRYPOINT ["/bin/sh"]