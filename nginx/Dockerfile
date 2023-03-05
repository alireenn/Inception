FROM alpine:3.16

RUN apk update -y && apk upgrade -y && apk add nginx openssl -y
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
#COPY content /usr/share/nginx/html

RUN openssl req -newkey rsa:2048 \
		-nodes \
		# esplicita la non creazione di una passphrase per la chiave privata ("No Data Encrypt. Standard")
		-keyout /etc/nginx/ssl/inception.key \
		# chiave privata
		-out /etc/nginx/ssl/inception.csr \
		# richiesta della creazione del certificato. Serve in caso di richiesta da fare al Certificate Authority (CA). NGINX la usa.
		-sha256 -new -sha256 -tls1_2 -tls1_3 \
		# protocolli supportati
		-subj "C=IT/ST=Lazio/L=Rome/O=PDC/CN=mcerchi"

COPY conf/default /etc/nginx

EXPOSE 443
