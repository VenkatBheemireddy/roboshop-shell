dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

useradd roboshop

rm -rf /app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

rm -rf /etc/systemd/system/catalogue.service
cp catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

rm -rf /etc/yum.repos.d/mongo.repo
cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.azdevopsv82.online </app/db/master-data.js