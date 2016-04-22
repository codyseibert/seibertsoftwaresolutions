yum update

# Install MongoDB Repo
touch /etc/yum.repos.d/mongodb-org-3.2.repo
echo '[mongodb-org-3.2]' >> /etc/yum.repos.d/mongodb-org-3.2.repo
echo 'name=MongoDB Repository' >> /etc/yum.repos.d/mongodb-org-3.2.repo
echo 'baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/' >> /etc/yum.repos.d/mongodb-org-3.2.repo
echo 'gpgcheck=1' >> /etc/yum.repos.d/mongodb-org-3.2.repo
echo 'enabled=1' >> /etc/yum.repos.d/mongodb-org-3.2.repo
echo 'gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc' >> /etc/yum.repos.d/mongodb-org-3.2.repo

# NodeJS 4.x setup
curl -sL https://rpm.nodesource.com/setup_4.x | bash -

yum install -y policycoreutils-python
semanage port -a -t mongod_port_t -p tcp 27017

yum install -y nodejs rpm-build git ruby mongodb-org
npm install -g coffee-script grunt-cli bower gulp
gem install sass

# npm rebuild node-sass
service mongod start
# coffee /vagrant/server/src/scripts/build_db.coffee
