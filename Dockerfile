
FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -yq libpq-dev build-essential git
WORKDIR /app
COPY Gemfile* ./

RUN gem install bundler && bundle install
ADD . /app

CMD ["bundle","exec","puma","-C","config/puma.rb"]
EXPOSE 3000
