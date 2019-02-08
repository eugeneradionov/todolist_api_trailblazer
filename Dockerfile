FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /todolist-trailbazer
WORKDIR /todolist-trailbazer

COPY . ./

RUN gem install bundler -v'1.17.2'
RUN bundle install --without development test

EXPOSE 3000

ENTRYPOINT [ "bundle", "exec" ]

CMD [ "rm -f /todolist-trailbazer/tmp/pids/server.pid && rails server -b 0.0.0.0" ]
