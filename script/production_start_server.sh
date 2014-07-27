#!/bin/bash

set -x

[ -f tmp/pids/server_1.pid ] && kill $(cat tmp/pids/server_1.pid)
[ -f tmp/pids/server_2.pid ] && kill $(cat tmp/pids/server_2.pid)
[ -f tmp/pids/server_3.pid ] && kill $(cat tmp/pids/server_3.pid)

rails s -d -p 3210 -e production -P `pwd`/tmp/pids/server_1.pid
rails s -d -p 3211 -e production -P `pwd`/tmp/pids/server_2.pid
rails s -d -p 3212 -e production -P `pwd`/tmp/pids/server_3.pid
