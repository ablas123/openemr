# استخدم الصورة الرسمية لـ OpenEMR
FROM openemr/openemr:latest

# انسخ شهادة SSL من مجلد db (المسار الصحيح) إلى مكان آمن داخل الحاوية
COPY db/ca.pem /etc/ssl/certs/ca-tidb.pem

# ثبّت عميل MySQL (للتأكد من وجوده، لكن الصورة ربما تحتويه)
RUN apt-get update && apt-get install -y default-mysql-client

# اضبط متغيرات البيئة التي تستخدمها OpenEMR للاتصال بقاعدة البيانات
ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem
