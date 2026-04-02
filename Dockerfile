FROM openemr/openemr:latest

# انسخ شهادة SSL من مجلد db (تأكد من وجودها)
COPY db/ca.pem /etc/ssl/certs/ca-tidb.pem

# تثبيت عميل MySQL (اختياري)
RUN apk add --no-cache mysql-client

# انسخ ملفات المشروع (بما في ذلك sqlconf.php المعدل)
COPY . /var/www/localhost/htdocs/openemr

# حذف معالج التثبيت نهائياً
RUN rm -f /var/www/localhost/htdocs/openemr/setup.php

# تعيين متغيرات البيئة للاتصال بقاعدة البيانات (TiDB Cloud)
ENV MYSQL_HOST=gateway01.eu-central-1.prod.aws.tidbcloud.com
ENV MYSQL_PORT=4000
ENV MYSQL_USER=4Q3JgFwtV72XTzm.root
ENV MYSQL_PASSWORD=hCCzJBE3Ko33HuTW
ENV MYSQL_DATABASE=openemr_db
ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem

# تعيين مستخدم OpenEMR الأول
ENV OE_USER=admin
ENV OE_PASS=admin123

# إعادة توجيه index.php إلى صفحة تسجيل الدخول
RUN echo "<?php header('Location: interface/login/login.php'); exit; ?>" > /var/www/localhost/htdocs/openemr/index.php

# التأكد من أن Apache يستمع على المنفذ 80 (لـ Render)
RUN sed -i 's/Listen 443/Listen 80/g' /etc/apache2/ports.conf && \
    sed -i 's/VirtualHost \*:443/VirtualHost \*:80/g' /etc/apache2/sites-enabled/default-ssl.conf 2>/dev/null || true

# بدء Apache
CMD ["apache2-foreground"]
