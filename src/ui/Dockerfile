#FROM ubuntu:16.04
FROM alpine:3.7
#RUN apt-get update \
#    && apt-get install -y ruby-full ruby-dev build-essential \
#    && gem install bundler --no-ri --no-rdoc

RUN apk add --update alpine-sdk \
    && apk add --update ruby ruby-dev \
    &&  gem install bundler --no-ri --no-rdoc

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
#ADD Gemfile* $APP_HOME/
COPY . $APP_HOME
RUN bundle install
#ADD . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]

