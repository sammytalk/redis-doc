#!/bin/bash
cd /redis/redis-doc
#git pull
cd /redis/redis-io
#git pull
/usr/local/bin/redis-server & 
REDIS_DOC=/redis/redis-doc /usr/local/bin/rackup -o 0.0.0.0 &
