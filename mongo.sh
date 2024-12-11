rm -rf /etc/yum.repos.d/mongo.repo
cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y

sed -i 's/127.0.0.1/0.0.0.0m' /etc/mongo.conf

systemctl enable mongod
systemctl start mongod


