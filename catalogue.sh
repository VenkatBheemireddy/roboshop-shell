# Install NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y


#Configure the application
useradd roboshop
rm -rf /app
mkdir /app

# Download the application code
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

# Download the dependencies
cd /app
npm install

#Setup SystemD Catalogue Service
cp catalogue.service /etc/systemd/system/catalogue.service

# Start the service
systemctl enable catalogue
systemctl start catalogue

# To load schema
cp /etc/yum.repos.d/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js