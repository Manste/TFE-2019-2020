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
