#!/bin/bash
#更新redis-doc及redis-io源码
cd /redis/redis-doc
git pull
cd /redis/redis-io
git pull
#启动redis服务
/usr/local/bin/redis-server & 
#rackup启动文档服务
REDIS_DOC=/redis/redis-doc /usr/local/bin/rackup -o 0.0.0.0 &
