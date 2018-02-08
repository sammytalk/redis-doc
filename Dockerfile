#基于ubuntu镜像构建
FROM ubuntu
#本人邮箱，欢迎交流
MAINTAINER Sammy.Xiong (xxm_0316@126.com)
#apt-get下载的时候禁止交互弹框
ENV DEBIAN_FRONTEND noninteractive
#删除原有apt-get数据源
RUN rm /etc/apt/sources.list
#使用阿里数据源
COPY ./sources.list /etc/apt/sources.list
#增加ruby仓库，下载依赖组建
RUN apt-get update
RUN apt-get install  -y python-software-properties software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install  -y git wget ruby2.4 ruby2.4-dev make gcc
#更换ruby国内源
RUN gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
WORKDIR /
RUN mkdir redis
WORKDIR redis
#git拉取redis-io（redis官网源码）和redis-doc（redis文档）
RUN GIT_SSL_NO_VERIFY=true git clone https://github.com/antirez/redis-io.git
RUN GIT_SSL_NO_VERIFY=true git clone https://github.com/antirez/redis-doc.git
WORKDIR /redis
#下载并make redis
RUN wget http://download.redis.io/releases/redis-4.0.8.tar.gz
RUN tar xzvf redis-4.0.8.tar.gz
RUN cd redis-4.0.8 && make && make install
ADD ./run.sh ./redis-io/
WORKDIR redis-io
#下载redis-io启动所需要组件
RUN gem install dep
RUN dep install
RUN chmod +x run.sh
#开放端口9292
EXPOSE 9292
#镜像启动后执行run.sh启动redis服务及文档服务
ENTRYPOINT /redis/redis-io/run.sh && /bin/bash
