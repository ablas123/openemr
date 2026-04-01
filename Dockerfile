# استخدم الصورة الرسمية لـ OpenEMR
FROM openemr/openemr:latest

# انسخ شهادة SSL من مجلد database إلى مكان آمن داخل الحاوية
COPY database/ca.pem /etc/ssl/certs/ca-tidb.pem

# ثبّت عميل MySQL (للتأكد من وجوده، لكن الصورة ربما تحتويه)
RUN apt-get update && apt-get install -y default-mysql-client

# اضبط متغيرات البيئة التي تستخدمها OpenEMR للاتصال بقاعدة البيانات
# هذه القيم يمكن تغطيتها لاحقاً بواسطة متغيرات البيئة في Render
ENV MYSQL_SSL_CA=/etc/ssl/certs/ca-tidb.pem

# سيبقى نقطة الدخول الافتراضية للصورة الأصلية، لا نحتاج لتغييرها
