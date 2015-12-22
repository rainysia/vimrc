# Version: 0.0.1
FROM rainysia/static_web
MAINTAINER rainysia "rainysia@gmail.com"
RUN apt-get update
RUN apt-get install -y -q nginx
RUN mkdir -p /var/www/html
RUN apt-get install -y vim
ADD nginx/global.conf /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf
COPY website/index.html /var/www/html/index.html
RUN echo 'Hi, i am in your container' \
        >> /var/www/html/index.html
EXPOSE 80
