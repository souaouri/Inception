FROM debian:bullseye

RUN apt update && apt upgrade -y && \
	apt install openssl nginx -y

RUN mkdir -p /etc/nginx/ssl /var/www/wordpress \
    && printf "MO\nDoar_megdaz\nDemnat\ndemnat\ndemnat\nsouaouri.42.fr\nsolimi@gmail.com\n" | \
    openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/nginx/ssl/pk.key -out /etc/nginx/ssl/ssc.crt -days 365

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]