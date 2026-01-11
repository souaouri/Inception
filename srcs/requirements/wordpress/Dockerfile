FROM debian:bullseye

RUN apt update && apt upgrade -y && \
	apt install php php-fpm php-mysqli\ 
	curl -y 

COPY ./tools/script.sh .

RUN chmod +x script.sh

RUN mkdir -p /var/www/wordpress /run/php

ENTRYPOINT ["./script.sh"]
