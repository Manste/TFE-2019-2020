# Suppression de la clé permettant de se connecter 
# à la base de données de Neutron
crudini --del /etc/neutron/neutron.conf database connection

# Accès à la file d'attente
crudini --set /etc/neutron/neutron.conf DEFAULT transport_url rabbit://openstack:openstack@controller

# Accès au service d'identité
crudini --set /etc/neutron/neutron.conf DEFAULT auth_strategy keystone
crudini --set /etc/neutron/neutron.conf keystone_authtoken www_authenticate_uri http://controller:5000
crudini --set /etc/neutron/neutron.conf keystone_authtoken auth_url http://controller:5000
crudini --set /etc/neutron/neutron.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/neutron/neutron.conf keystone_authtoken auth_type password
crudini --set /etc/neutron/neutron.conf keystone_authtoken project_domain_name default
crudini --set /etc/neutron/neutron.conf keystone_authtoken user_domain_name default
crudini --set /etc/neutron/neutron.conf keystone_authtoken project_name service
crudini --set /etc/neutron/neutron.conf keystone_authtoken username neutron
crudini --set /etc/neutron/neutron.conf keystone_authtoken password openstack
crudini --set /etc/neutron/neutron.conf oslo_concurrency lock_path /var/lib/neutron/tmp

#************ Configuration de l'agent du pont linux

# Mappage du réseau virtuel du fournisseur à l'interface réseau 
# physique du fournisseur 
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini linux_bridge physical_interface_mappings provider:eth1

# Activation des réseaux de superposition VXLAN
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan enable_vxlan  true

# Configuration de l'adresse IP de l'interface réseau physique
# qui gère les réseaux de superposition
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan local_ip 10.0.0.31

# Activation de la couche 2
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan l2_population true

# Activation des groupes de sécurité et du pilote du 
# parefeu iptables du pont Linux
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini securitygroup enable_security_group true
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini securitygroup firewall_driver neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

#*********** Donner à Nova l'accès à Neutron
crudini --set /etc/nova/nova.conf neutron auth_url http://controller:5000
crudini --set /etc/nova/nova.conf neutron auth_type password
crudini --set /etc/nova/nova.conf neutron project_domain_name default
crudini --set /etc/nova/nova.conf neutron user_domain_name default
crudini --set /etc/nova/nova.conf neutron region_name RegionOne
crudini --set /etc/nova/nova.conf neutron project_name service
crudini --set /etc/nova/nova.conf neutron username neutron
crudini --set /etc/nova/nova.conf neutron password openstack

# Configuration de l'OS pour qu'il prenne en charge
# les filtres de pont réseau en désactivant ceux d'ipv6
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=0" >> /etc/sysctl.conf
modprobe br_netfilter
sysctl -p
