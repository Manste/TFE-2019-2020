# Accès à la base de données Cinder
crudini --set /etc/cinder/cinder.conf database connection mysql+pymysql://cinder:openstack@controller/cinder

# Accès à la file d'attente RabbitMQ
crudini --set /etc/cinder/cinder.conf DEFAULT transport_url rabbit://openstack:openstack@controller

# Connexion au service d'identité
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

# Définir l'adresse IP de gestion du block1
crudini --set /etc/cinder/cinder.conf DEFAULT my_ip 10.0.0.41

# Configuration du backend LVM avec le pilote LVM
crudini --set /etc/cinder/cinder.conf lvm volume_driver cinder.volume.drivers.lvm.LVMVolumeDriver 

# Configuration du groupe de volumes
crudini --set /etc/cinder/cinder.conf lvm volume_group cinder-volumes

# Configuration du protocole iSCSI
crudini --set /etc/cinder/cinder.conf lvm target_protocol iscsi

# Configuration du service iSCSI
crudini --set /etc/cinder/cinder.conf lvm target_helper tgtadm

# Activation du backend LVM
crudini --set /etc/cinder/cinder.conf DEFAULT enabled_backends lvm

# Configuration l'emplacement de l'API du service d'image
crudini --set /etc/cinder/cinder.conf DEFAULT glance_api_servers http://controller:9292

# Configuration du chemin de verrouillage
crudini --set /etc/cinder/cinder.conf oslo_concurrency lock_path /var/lib/cinder/tmp
