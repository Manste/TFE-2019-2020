# Connexion à la base de données de placement
crudini --set /etc/placement/placement.conf placement_database connection mysql+pymysql://placement:openstack@controller/placement

# Connexion à keystone
crudini --set /etc/placement/placement.conf api auth_strategy keystone
crudini --set /etc/placement/placement.conf keystone_authtoken auth_url http://controller:5000/v3
crudini --set /etc/placement/placement.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/placement/placement.conf keystone_authtoken auth_type password
crudini --set /etc/placement/placement.conf keystone_authtoken project_domain_name Default
crudini --set /etc/placement/placement.conf keystone_authtoken user_domain_name Default
crudini --set /etc/placement/placement.conf keystone_authtoken project_name service
crudini --set /etc/placement/placement.conf keystone_authtoken username placement
crudini --set /etc/placement/placement.conf keystone_authtoken password openstack
