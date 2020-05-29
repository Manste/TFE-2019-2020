# Accès à la base de données de cinder
crudini --set /etc/cinder/cinder.conf database connection mysql+pymysql://cinder:openstack@controller/cinder

# Accès à la file d'attente des messages
crudini --set /etc/cinder/cinder.conf DEFAULT transport_url rabbit://openstack:openstack@controller

# Accès au service d'identité
crudini --set /etc/cinder/cinder.conf DEFAULT auth_strategy keystone
crudini --set /etc/cinder/cinder.conf keystone_authtoken www_authenticate_uri http://controller:5000
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_url http://controller:5000
crudini --set /etc/cinder/cinder.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_type password
crudini --set /etc/cinder/cinder.conf keystone_authtoken project_domain_name default
crudini --set /etc/cinder/cinder.conf keystone_authtoken user_domain_name default
crudini --set /etc/cinder/cinder.conf keystone_authtoken project_name service
crudini --set /etc/cinder/cinder.conf keystone_authtoken username cinder
crudini --set /etc/cinder/cinder.conf keystone_authtoken password openstack

# Configuration le chemin de verrouillage 
crudini --set /etc/cinder/cinder.conf oslo_concurrency lock_path /var/lib/cinder/tmp

# Définir l'adresse IP de management du noeud controller
crudini --set /etc/cinder/cinder.conf DEFAULT my_ip 10.0.0.11
  
crudini --set /etc/nova/nova.conf cinder os_region_name RegionOne
