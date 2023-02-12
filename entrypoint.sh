#!/bin/sh

rm -f tmp/pids/server.pid
bundle exec rails db:create
bundle exec rails db:migrate

bundle exec rails server -b 0.0.0.0 -p 3000
