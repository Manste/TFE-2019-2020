# Connexion à la base de données de nova_api
crudini --set /etc/nova/nova.conf api_database connection mysql+pymysql://nova:openstack@controller/nova_api

# Connexion  à la base de données de nova
crudini --set /etc/nova/nova.conf database connection mysql+pymysql://nova:openstack@controller/nova

# Configuration à la file d'attente des messages RabbitMQ
crudini --set /etc/nova/nova.conf DEFAULT transport_url rabbit://openstack:openstack@controller:5672/

#configuration au service d'identité
crudini --set /etc/nova/nova.conf api auth_strategy keystone
crudini --set /etc/nova/nova.conf keystone_authtoken www_authenticate_uri http://controller:5000/
crudini --set /etc/nova/nova.conf keystone_authtoken auth_url http://controller:5000/
crudini --set /etc/nova/nova.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/nova/nova.conf keystone_authtoken auth_type password
crudini --set /etc/nova/nova.conf keystone_authtoken project_domain_name Default
crudini --set /etc/nova/nova.conf keystone_authtoken user_domain_name Default
crudini --set /etc/nova/nova.conf keystone_authtoken project_name service
crudini --set /etc/nova/nova.conf keystone_authtoken username nova
crudini --set /etc/nova/nova.conf keystone_authtoken password openstack

# Configuration de l'adresse IP de management du contrôleur
crudini --set /etc/nova/nova.conf DEFAULT my_ip 10.0.0.11

# Activation de la prise en charge du service de mise en réseau
crudini --set /etc/nova/nova.conf DEFAULT use_neutron true
crudini --set /etc/nova/nova.conf DEFAULT firewall_driver nova.virt.firewall.NoopFirewallDriver

# Configuration du proxy vnc pour utiliser IP de gestion
crudini --set /etc/nova/nova.conf vnc enabled true
crudini --set /etc/nova/nova.conf vnc server_listen '$my_ip'
crudini --set /etc/nova/nova.conf vnc server_proxyclient_address '$my_ip'

# Référez l'API du service Glance
crudini --set /etc/nova/nova.conf glance api_servers http://controller:9292

# Configuration du chemin de verrouillage
crudini --set /etc/nova/nova.conf oslo_concurrency lock_path /var/lib/nova/tmp

# Acces au service Placement
crudini --set /etc/nova/nova.conf placement region_name RegionOne
crudini --set /etc/nova/nova.conf placement project_domain_name Default
crudini --set /etc/nova/nova.conf placement project_name service
crudini --set /etc/nova/nova.conf placement auth_type password
crudini --set /etc/nova/nova.conf placement user_domain_name Default
crudini --set /etc/nova/nova.conf placement auth_url http://controller:5000/v3
crudini --set /etc/nova/nova.conf placement username placement
crudini --set /etc/nova/nova.conf placement password openstack

# Suppression de la clé log_dir
crudini --del /etc/nova/nova.conf DEFAULT log_dir
