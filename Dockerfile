FROM registry.cn-beijing.aliyuncs.com/codeforfun/config-server:1.0.7

FROM registry.cn-beijing.aliyuncs.com/codeforfun/config-server-frontend:1.0.7

FROM registry.cn-beijing.aliyuncs.com/codeforfun/docker-supervisor-nginx-java:latest
ENV LANG C.UTF-8

WORKDIR /app
COPY --from=0 /app/app.jar /app/data/app.jar
COPY --from=1 /usr/share/nginx/html /app/data/html
COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/supervisord.conf /app/conf/supervisord.conf

CMD ["supervisord", "-n", "-c", "/app/conf/supervisord.conf"]