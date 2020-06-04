# Accès à la base de données de Neutron
crudini --set /etc/neutron/neutron.conf database connection mysql+pymysql://neutron:openstack@controller/neutron

# Activation du plugin Modular Layer 2 (ML2), du service de routage 
# et du chauvechement des adresses IP
crudini --set /etc/neutron/neutron.conf DEFAULT core_plugin ml2
crudini --set /etc/neutron/neutron.conf DEFAULT service_plugins router
crudini --set /etc/neutron/neutron.conf DEFAULT allow_overlapping_ips true

# Accès à la file d'attente des messages
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

# Configuration du service de réseau pour notifier 
# notifier le noeud Compute des modifications de la 
# topologie du réseau
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_status_changes true
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_data_changes true
crudini --set /etc/neutron/neutron.conf nova auth_url http://controller:5000
crudini --set /etc/neutron/neutron.conf nova auth_type password
crudini --set /etc/neutron/neutron.conf nova project_domain_name default
crudini --set /etc/neutron/neutron.conf nova user_domain_name default
crudini --set /etc/neutron/neutron.conf nova region_name RegionOne
crudini --set /etc/neutron/neutron.conf nova project_name service
crudini --set /etc/neutron/neutron.conf nova username nova
crudini --set /etc/neutron/neutron.conf nova password openstack

# Configuration du chemin de vérouillage
crudini --set /etc/neutron/neutron.conf oslo_concurrency lock_path /var/lib/neutron/tmp

#*************** Configuration du plugin Modular Layer 2

# Activation des réseaux plats, Vlan et VXLAN
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 type_drivers 'flat,vlan,vxlan'

# Activation des réseaux libre-service VXLAN
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 tenant_network_types vxlan

# Activation de Linuxbridge et du mécanismes de couche 2
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 mechanism_drivers 'linuxbridge,l2population'

# Activation du pilote d'extension de sécurité du port
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 extension_drivers port_security

# Configuration du réseau virtuel du fournisseur en tant réseau plat
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_flat flat_networks provider

# Configuration de la plage d'identificateurs de réseau VXLAN pour le réseau libre-service
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_flat vni_ranges '1:1000'

# Activation de l'ipset pour augmenter l'éfficacité des règles de groupe de sécurité
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup enable_ipset true

#**************** Configuration de l'agent Linuxbridge

# Mappage du réseau virtuel du fournisseur à l'interface réseau physique du fournisseur
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini linux_bridge physical_interface_mappings provider:eth1

# Activation de la superposition VXLAN
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan enable_vxlan true

# Configuration de l'adresse IP de l'interface réseau physique 
# qui gère les réseaux de superposition
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan local_ip 10.0.0.11

# Activation de la couche 2
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan l2_population true

# Activation des groupes de sécurité
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini securitygroup enable_security_group true

# Configuration du pilote du pare-feu iptable
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini securitygroup firewall_driver neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

# Configuration de l'OS pour qu'il prenne en charge
# les filtres de pont réseau en désactivant ceux d'ipv6
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=0" >> /etc/sysctl.conf
modprobe br_netfilter
sysctl -p

#*************** Configuration de l'agent de couche 3

# Configuration du pilote d'interface de Linuxbridge
crudini --set /etc/neutron/l3_agent.ini DEFAULT interface_driver linuxbridge

#*************** Configuration de l'agent DHCP

# Configuration du pilote d'interface du pont Linux
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver linuxbridge

# Configuration du pilote DHCP Dnsmasq
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_driver neutron.agent.linux.dhcp.Dnsmasq

# Activation des metadonnées isolées 
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT enable_isolated_metadata true

#************* Configuration de l'agent de métadonnées

# Configuration de l'hôte de métadonnées et le secret partagé
crudini --set /etc/neutron/metadata_agent.ini DEFAULT nova_metadata_host controller
crudini --set /etc/neutron/metadata_agent.ini DEFAULT metadata_proxy_shared_secret openstack

#************* Configuration de Nova pour utiliser le service
# de mise en réseau

# Configuration des paramètres d'accès à Neutron
crudini --set /etc/nova/nova.conf neutron auth_url http://controller:5000
crudini --set /etc/nova/nova.conf neutron auth_type password
crudini --set /etc/nova/nova.conf neutron project_domain_name default
crudini --set /etc/nova/nova.conf neutron user_domain_name default
crudini --set /etc/nova/nova.conf neutron region_name RegionOne
crudini --set /etc/nova/nova.conf neutron project_name service
crudini --set /etc/nova/nova.conf neutron username neutron
crudini --set /etc/nova/nova.conf neutron password openstack

# Activation du proxy de métadonnées
crudini --set /etc/nova/nova.conf neutron service_metadata_proxy true

# Configuration du secret
crudini --set /etc/nova/nova.conf neutron metadata_proxy_shared_secret openstack 

# Activation de la création des réseaux libre-service
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 tenant_network_types vxlan
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_vxlan vni_ranges 1:1000

# Configuration du débogage de neutron oslo.messaging
# Afin de traquer des cas spécifiques de bugs (la communication de neutron 
# avec les autres services via RabbitMQ)
# Nécessaire pour la détection des erreurs en cas de soucis
crudini --set /etc/neutron/neutron.conf default_log_levels 'amqp=WARN,amqplib=WARN,boto=WARN,qpid=WARN,sqlalchemy=WARN,suds=INFO,oslo.messaging=DEBUG,oslo_messaging=INFO,iso8601=WARN,requests.packages.urllib3.connectionpool=WARN,urllib3.connectionpool=WARN,websocket=WARN,requests.packages.urllib3.util.retry=WARN,urllib3.util.retry=WARN,keystonemiddleware=WARN,routes.middleware=WARN,stevedore=WARN,taskflow=WARN,keystoneauth=WARN,oslo.cache=INFO,oslo_policy=INFO,dogpile.core.dogpile=INFO'
