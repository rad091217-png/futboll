FROM ruby:2.7.2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn sqlite3 vim
# sqlite3 は container 分けるより、package から入れるのが主流っぽい
# vim は必須ではないが,デバッグ上あるほうがいい。
WORKDIR /app
COPY ./ /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
RUN yarn install

EXPOSE 3000

# # Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]