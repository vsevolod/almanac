FROM ruby:2.5.1

# Copy rails app
RUN mkdir /app
WORKDIR /app
RUN gem install bundler
ADD . /app
COPY ./Gemfile* /app/

RUN apt-get update && apt-get install -y curl
RUN bundle install

# Other settings
CMD ["puma", "-C", "./config/puma.rb"]
