#!/bin/bash

set -x

[ -f tmp/pids/server.pid ] && kill $(cat tmp/pids/server.pid)

rails s -d -p 3210 -e production -P `pwd`/tmp/pids/server.pid
