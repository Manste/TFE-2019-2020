#!/bin/bash

#*************************** controller*****************************

#crudini va nous servir plutard pour la configuration de certains packages

#Configurer la base de données SQL
sudo su

apt install mariadb-server python3-pymysql crudini -y

cat > /etc/mysql/mariadb.conf.d/99-openstack.cnf << EOT
[mysqld]
bind-address = 10.0.0.11

default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOT
service mysql restart

#Configurer la File d'attente de messages 
apt install rabbitmq-server -y

rabbitmqctl add_user openstack RABBIT_PASS

rabbitmqctl set_permissions openstack ".*" ".*" ".*"

#Configuration de Memcached
apt install memcached python3-memcache -y

#Allez dans le fichier /etc/memcached.conf et modifiez la ligne "-l 127.0.0.1" en "-l 10.0.0.11"
#Ensuite redemarrez le service memcached "service memcached restart"

#Configuration d'ETCD
apt install etcd -y

cat >> /etc/default/etcd << EOT
ETCD_NAME="controller"
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
ETCD_INITIAL_CLUSTER="controller=http://10.0.0.11:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://10.0.0.11:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://10.0.0.11:2379"
ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="http://10.0.0.11:2379"
EOT
sudo su

systemctl enable etcd

systemctl restart etcd

#Installation et Configuration de Keystone
mysql -u root -p <<< "CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'KEYSTONE_DBPASS';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'KEYSTONE_DBPASS';"

apt install keystone libapache2-mod-wsgi -y

crudini --set /etc/keystone/keystone.conf database connection mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

crudini --set /etc/keystone/keystone.conf token provider fernet

su -s /bin/sh -c "keystone-manage db_sync" keystone

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
  
echo "ServerName controller" >> /etc/apache2/apache2.conf

service apache2 restart

exit

cat > ~/admin-openrc << EOT
export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=ADMIN_PASS
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
EOT

openstack project create --domain default \
  --description "Service Project" service
  
openstack project create --domain default \
  --description "Demo Project" demo  
  
openstack user create --domain default \
  --password "DEMO_PASS" demo

openstack role create demorole

openstack role add --project demo --user demo demorole 

cat > ~/demo-openrc << EOT
export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=demo
export OS_USERNAME=demo
export OS_PASSWORD=DEMO_PASS
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
EOT


