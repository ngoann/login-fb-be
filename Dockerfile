FROM ruby:3.0.0

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-key update \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs yarn less \
  && sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

WORKDIR /app

COPY Gemfile* ./
RUN bundle install -j4

COPY . .
RUN mkdir -p tmp/sockets

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
