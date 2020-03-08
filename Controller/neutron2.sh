crudini --set /etc/neutron/metadata_agent.ini DEFAULT nova_metadata_host controller
crudini --set /etc/neutron/metadata_agent.ini DEFAULT metadata_proxy_shared_secret METADATA_SECRET

crudini --set /etc/nova/nova.conf neutron auth_url http://controller:5000
crudini --set /etc/nova/nova.conf neutron auth_type password
crudini --set /etc/nova/nova.conf neutron project_domain_name default
crudini --set /etc/nova/nova.conf neutron user_domain_name default
crudini --set /etc/nova/nova.conf neutron region_name RegionOne
crudini --set /etc/nova/nova.conf neutron project_name service
crudini --set /etc/nova/nova.conf neutron username neutron
crudini --set /etc/nova/nova.conf neutron password openstack
crudini --set /etc/nova/nova.conf neutron service_metadata_proxy true
crudini --set /etc/nova/nova.conf neutron metadata_proxy_shared_secret openstack 