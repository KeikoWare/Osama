
export DEBIAN_FRONTEND=noninteractive
sudo echo mysql-server-5.5 mysql-server/root_password password P@ssw0rd | sudo debconf-set-selections
sudo echo mysql-server-5.5 mysql-server/root_password_again password P@ssw0rd | sudo debconf-set-selections
sudo apt-get update -q
sudo apt-get install -q -y apache2
sudo apt-get install -q -y php5 libapache2-mod-php5
sudo apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mysql-server-5.5 mysql-client-5.5 php5-mysql

sudo echo phpmyadmin phpmyadmin/mysql/admin-pass password P@ssw0rd | sudo debconf-set-selections
sudo echo phpmyadmin phpmyadmin/mysql/app-pass password | sudo debconf-set-selections
sudo echo phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2  | sudo debconf-set-selections
sudo echo phpmyadmin phpmyadmin/dbconfig-install boolean true  | sudo debconf-set-selections

sudo apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" phpMyAdmin 

sudo mkdir /usr/share/osama
sudo cp -R ~/osama/html/* /usr/share/osama
sudo chmod -R 777 /usr/share/osama/*
sudo cp ~/osama/setup/osama.conf /etc/apache2/conf-available
sudo ln -s /etc/apache2/conf-available/osama.conf /etc/apache2/conf-enabled/osama.conf

sudo service apache2 restart

mysql --user=root --password=P@ssw0rd < ~/osama/setup/create_db.sql
