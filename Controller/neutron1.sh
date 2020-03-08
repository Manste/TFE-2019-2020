crudini --set /etc/neutron/neutron.conf database connection mysql+pymysql://neutron:openstack@controller/neutron
crudini --set /etc/neutron/neutron.conf DEFAULT core_plugin ml2
crudini --set /etc/neutron/neutron.conf DEFAULT service_plugins ''
crudini --set /etc/neutron/neutron.conf DEFAULT transport_url rabbit://openstack:openstack@controller
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
crudini --set /etc/neutron/neutron.conf oslo_concurrency lock_path /var/lib/neutron/tmp

crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 type_drivers 'flat,vlan'
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 tenant_network_types ''
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 mechanism_drivers linuxbridge
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 extension_drivers port_security
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_flat flat_networks provider
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup enable_ipset true

crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini linux_bridge physical_interface_mappings provider:eth1
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini vxlan enable_vxlan false
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini securitygroup enable_security_group true
crudini --set /etc/neutron/plugins/ml2/linuxbridge_agent.ini firewall_driver neutron.agent.linux.iptables_firewall.IptablesFirewallDriver

crudini --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver linuxbridge
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_driver neutron.agent.linux.dhcp.Dnsmasq
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT enable_isolated_metadata true

echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=0" >> /etc/sysctl.conf
modprobe br_netfilter
sysctl -p
