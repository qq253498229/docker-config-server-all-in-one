FROM node:13.10.1-alpine
RUN npm config set registry https://registry.npm.taobao.org
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add git
WORKDIR /app
RUN git clone https://gitee.com/consolelog/demo-config-frontend.git
RUN cd demo-config-frontend && git checkout tags/1.0.0
RUN cd demo-config-frontend && npm install && npm run build
RUN ls demo-config-frontend

#FROM registry.cn-beijing.aliyuncs.com/codeforfun/docker-supervisor-nginx-java:latest