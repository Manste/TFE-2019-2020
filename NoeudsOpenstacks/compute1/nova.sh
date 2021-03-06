#!/bin/bash

# Suppression de la clé log_dir
crudini --del /etc/nova/nova.conf DEFAULT log_dir

# Accès à la file d'attente des messages RabbitMQ
crudini --set /etc/nova/nova.conf DEFAULT transport_url rabbit://openstack:openstack@controller

# Accès au service d'identité
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

# Référez l'adresse IP du management de compute1
crudini --set /etc/nova/nova.conf DEFAULT my_ip 10.0.0.31

# Activation de la prise en charge du service de mise en réseau
crudini --set /etc/nova/nova.conf DEFAULT use_neutron true
crudini --set /etc/nova/nova.conf DEFAULT firewall_driver nova.virt.firewall.NoopFirewallDriver

#Configuration l'accès à distance aux instances
crudini --set /etc/nova/nova.conf DEFAULT force_config_drive true

# Configuration l'accès à la console distante
crudini --set /etc/nova/nova.conf vnc enabled true
crudini --set /etc/nova/nova.conf vnc server_listen 0.0.0.0
crudini --set /etc/nova/nova.conf vnc server_proxyclient_address '$my_ip'
crudini --set /etc/nova/nova.conf vnc novncproxy_base_url http://controller:6080/vnc_auto.html

# Referencement à l'API du service Glance pour les images
crudini --set /etc/nova/nova.conf glance api_servers http://controller:9292

# Configuration du chemin de verrouillage
crudini --set /etc/nova/nova.conf oslo_concurrency lock_path /var/lib/nova/tmp

#Accès au placement
crudini --set /etc/nova/nova.conf placement region_name RegionOne
crudini --set /etc/nova/nova.conf placement project_domain_name Default
crudini --set /etc/nova/nova.conf placement project_name service
crudini --set /etc/nova/nova.conf placement auth_type password
crudini --set /etc/nova/nova.conf placement user_domain_name Default
crudini --set /etc/nova/nova.conf placement auth_url http://controller:5000/v3
crudini --set /etc/nova/nova.conf placement username placement
crudini --set /etc/nova/nova.conf placement password openstack
