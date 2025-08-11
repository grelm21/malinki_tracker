# # syntax = docker/dockerfile:1
#
# # Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
# ARG RUBY_VERSION=3.2.2
# FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
#
# # Rails app lives here
# WORKDIR /rails
#
# # Set production environment
# ENV RAILS_ENV="production" \
#     BUNDLE_DEPLOYMENT="1" \
#     BUNDLE_PATH="/usr/local/bundle" \
#     BUNDLE_WITHOUT="development"
#
#
# # Throw-away build stage to reduce size of final image
# FROM base as build
#
# # Install packages needed to build gems
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config
#
# # Install application gems
# COPY Gemfile Gemfile.lock ./
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile
#
# # Copy application code
# COPY . .
#
# # Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/
#
# # Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
#
#
# # Final stage for app image
# FROM base
#
# # Install packages needed for deployment
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y curl libvips postgresql-client && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
# # Copy built artifacts: gems, application
# COPY --from=build /usr/local/bundle /usr/local/bundle
# COPY --from=build /rails /rails
#
# # Run and own only the runtime files as a non-root user for security
# RUN useradd rails --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
# USER rails:rails
#
# # Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
# # Start the server by default, this can be overwritten at runtime
# EXPOSE 3000
# CMD ["./bin/rails", "server"]
#

FROM ruby:3.2.2

RUN curl -fsSL https://deb.nodesource.com/setup_18.x

# RUN curl -fsSL https://deb.nodesource.com/setup_18.x

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    cron \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists/*

RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

ENV RAILS_ROOT /var/www/malinki_tracker

RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY . .

RUN rm -rf node_modules vendor

RUN gem install rails bundler

RUN bundle install --jobs 20 --retry 5

RUN npm install

RUN chmod +x ./docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["./docker-entrypoint.sh"]
