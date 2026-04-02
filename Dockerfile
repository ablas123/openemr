FROM openemr/openemr:latest

# ========================
# إعدادات SSL وقاعدة البيانات
# ========================

# انسخ شهادة SSL من مجلد db (تأكد من وجود الملف db/ca.pem في المستودع)
COPY db/ca.pem /etc/ssl/certs/ca-tidb.pem

# تثبيت عميل MySQL (اختياري، للتأكد من وجوده)
RUN apk add --no-cache mysql-client

# ========================
# نسخ ملفات المشروع
# ========================
COPY . /var/www/localhost/htdocs/openemr

# ========================
# حذف معالج التثبيت الرئيسي وأي ملفات setup.php أخرى
# ========================
RUN rm -f /var/www/localhost/htdocs/openemr/setup.php
RUN find /var/www/localhost/htdocs/openemr -name "setup.php" -type f -delete

# ========================
# إعادة توجيه index.php إلى صفحة تسجيل الدخول
# ========================
RUN echo "<?php header('Location: interface/login/login.php'); exit; ?>" > /var/www/localhost/htdocs/openemr/index.php

# ========================
# تكوين Apache للاستماع على المنفذ 80 (ضروري لـ Render)
# ========================
RUN sed -i 's/Listen 443/Listen 80/g' /etc/apache2/ports.conf && \
    sed -i 's/VirtualHost \*:443/VirtualHost \*:80/g' /etc/apache2/sites-enabled/default-ssl.conf 2>/dev/null || true

# ========================
# متغيرات البيئة للاتصال بقاعدة بيانات TiDB Cloud
# ========================
ENV MYSQL_HOST=gateway01.eu-central-1.prod.aws.tidbcloud.com
ENV MYSQL_PORT=4000
ENV MYSQL_USER=4Q3JgFwtV72XTzm.root
ENV MYSQL_PASSWORD=hCCzJBE3Ko33HuTW
ENV MYSQL_DATABASE=openemr_db
ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem

# ========================
# بيانات المستخدم الإداري الأول (للتثبيت التلقائي)
# ========================
ENV OE_USER=admin
ENV OE_PASS=admin123

# ========================
# بدء تشغيل Apache
# ========================
CMD ["apache2-foreground"]
