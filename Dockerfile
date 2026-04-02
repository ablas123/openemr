FROM openemr/openemr:latest

COPY db/ca.pem /etc/ssl/certs/ca-tidb.pem
RUN apk add --no-cache mysql-client

COPY . /var/www/localhost/htdocs/openemr

# حذف setup.php نهائيًا من الحاوية
RUN rm -f /var/www/localhost/htdocs/openemr/setup.php

ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem
