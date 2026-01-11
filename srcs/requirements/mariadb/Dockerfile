FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y  \
	&& apt-get install mariadb-client mariadb-server -y 

COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]