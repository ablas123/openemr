# استخدم الصورة الرسمية لـ OpenEMR (Alpine-based)
FROM openemr/openemr:latest

# انسخ شهادة SSL (المسار الآن db/ca.pem)
COPY db/ca.pem /etc/ssl/certs/ca-tidb.pem

# ثبّت عميل MySQL باستخدام apk (مدير حزم Alpine)
RUN apk add --no-cache mysql-client

# اضبط متغير البيئة لشهادة SSL
ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem
