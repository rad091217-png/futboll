FROM ruby:2.7.2

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client
WORKDIR /app
COPY ./ /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
RUN yarn install

EXPOSE 3000

# # Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]