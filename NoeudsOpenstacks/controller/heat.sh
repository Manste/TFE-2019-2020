# Accès à la base de données 
crudini --set /etc/heat/heat.conf database connection mysql+pymysql://heat:openstack@controller/heat

# Accès à la file d'attente
crudini --set /etc/heat/heat.conf DEFAULT transport_url rabbit://openstack:openstack@controller

# Accès au service d'identité
crudini --set /etc/heat/heat.conf keystone_authtoken www_authenticate_uri http://controller:5000
crudini --set /etc/heat/heat.conf keystone_authtoken auth_url http://controller:5000
crudini --set /etc/heat/heat.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/heat/heat.conf keystone_authtoken auth_type password
crudini --set /etc/heat/heat.conf keystone_authtoken project_domain_name default
crudini --set /etc/heat/heat.conf keystone_authtoken user_domain_name default
crudini --set /etc/heat/heat.conf keystone_authtoken project_name service
crudini --set /etc/heat/heat.conf keystone_authtoken username heat
crudini --set /etc/heat/heat.conf keystone_authtoken password openstack
crudini --set /etc/heat/heat.conf trustee auth_type password 
crudini --set /etc/heat/heat.conf trustee auth_url http://controller:5000
crudini --set /etc/heat/heat.conf trustee username heat 
crudini --set /etc/heat/heat.conf trustee password openstack 
crudini --set /etc/heat/heat.conf trustee user_domain_name default  
crudini --set /etc/heat/heat.conf clients_keystone auth_uri http://controller:5000

# Configuration des URL des métadonnées et 
# des conditions d'attente
crudini --set /etc/heat/heat.conf DEFAULT heat_metadata_server_url http://controller:8000
crudini --set /etc/heat/heat.conf DEFAULT heat_waitcondition_server_url http://controller:8000/v1/waitcondition

# Configuration du domaine du service Heat 
# et des informations relatives d'identification administratives
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin heat_domain_admin
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin_password openstack
crudini --set /etc/heat/heat.conf DEFAULT stack_user_domain_name heat
