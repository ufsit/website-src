FROM ruby:2.3.3

WORKDIR /tmp

COPY Gemfile /tmp/

RUN gem install bundle
RUN bundle update && bundle check && bundle install

WORKDIR /src

EXPOSE 4000

ENTRYPOINT jekyll serve --host 0.0.0.0
# ENTRYPOINT rake generate
