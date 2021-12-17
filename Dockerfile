FROM arm64v8/ubuntu:22.04

WORKDIR /app

ENV TZ=US/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV PINOT_VERSION=0.9.2
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends ca-certificates wget default-jre \
    && wget https://downloads.apache.org/pinot/apache-pinot-$PINOT_VERSION/apache-pinot-$PINOT_VERSION-bin.tar.gz \
    && tar -zxvf apache-pinot-$PINOT_VERSION-bin.tar.gz \
    && mv apache-pinot-$PINOT_VERSION-bin pinot \
    && rm -rf /var/lib/apt/lists/* 

# expose ports for controller/broker/server/admin
EXPOSE 9000 8099 8098 8097 8096

WORKDIR /app/pinot
ENTRYPOINT ["./bin/pinot-admin.sh"]

CMD ["-help"]