FROM golang:latest
LABEL maintainer="Xendera Team <hello@xendera.com>"

ENV MONGODB_URL mongodb://comment_db:27017
ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && go get -d && go build -o /bin/mongodb_exporter \
    && rm -rf "$GOPATH"

EXPOSE 9216

ENTRYPOINT [ "/bin/mongodb_exporter" ]

