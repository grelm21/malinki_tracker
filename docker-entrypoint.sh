#!/bin/sh

set -e

if [ -f tmp/pids/server_1.pid ]; then
  rm tmp/pids/server_1.pid
fi

bundle exec rails s -b 0.0.0.0 -e development
