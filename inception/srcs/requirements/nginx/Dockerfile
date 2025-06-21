FROM debian:bullseye

RUN apt update && apt upgrade -y && \
	apt install openssl nginx -y

	
RUN mkdir -p /etc/nginx/ssl


RUN echo  "MO\nOCP-STATE\nKHOURIBGA\n1337\n1337\nsouaouri.42.fr\nsupport@gmail.com" > here_string.txt


RUN openssl req -x509 -nodes -newkey rsa:4096 -keyout pk.key -out ssc.crt -days 162 <here_string.txt

RUN cp ./ssc.crt /etc/nginx/ssl/

RUN cp ./pk.key /etc/nginx/ssl/

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]