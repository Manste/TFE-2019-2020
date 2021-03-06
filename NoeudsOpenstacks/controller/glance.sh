# Connexion à la base de données de Glance
crudini --set /etc/glance/glance-api.conf database connection mysql+pymysql://glance:openstack@controller/glance

# Connexion à keystone
crudini --set /etc/glance/glance-api.conf keystone_authtoken www_authenticate_uri http://controller:5000
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_url http://controller:5000
crudini --set /etc/glance/glance-api.conf keystone_authtoken memcached_servers controller:11211
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_type password
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_domain_name Default
crudini --set /etc/glance/glance-api.conf keystone_authtoken user_domain_name Default
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_name service
crudini --set /etc/glance/glance-api.conf keystone_authtoken username glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken password openstack

crudini --set /etc/glance/glance-api.conf paste_deploy flavor keystone

# Configuration du dépôt des images sur glances
crudini --set /etc/glance/glance-api.conf glance_store stores "file,http"
crudini --set /etc/glance/glance-api.conf glance_store default_store file
crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir /var/lib/glance/images/
