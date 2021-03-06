# Configuration du port de liaison du service swift
crudini --set /etc/swift/proxy-server.conf DEFAULT bind_port 8080

# Spécifier l'utilisateur du service swift
crudini --set /etc/swift/proxy-server.conf DEFAULT user swift

# Spécifier le repertoitre de configuration du service swift
crudini --set /etc/swift/proxy-server.conf DEFAULT swift_dir /etc/swift

# Définir les modules 
crudini --set /etc/swift/proxy-server.conf pipeline:main pipeline 'catch_errors gatekeeper healthcheck proxy-logging cache container_sync bulk ratelimit authtoken keystoneauth container-quotas account-quotas slo dlo versioned_writes proxy-logging proxy-server'

# Activation la création automatique de compte
crudini --set /etc/swift/proxy-server.conf app:proxy-server use 'egg:swift#proxy'
crudini --set /etc/swift/proxy-server.conf app:proxy-server account_autocreate True

# Définir les rôles ayant droit d'utilisateur le service
crudini --set /etc/swift/proxy-server.conf filter:keystoneauth use 'egg:swift#keystoneauth'
crudini --set /etc/swift/proxy-server.conf filter:keystoneauth operator_roles 'admin,user,heat_stack_owner'

# Accès au service d'identité
crudini --set /etc/swift/proxy-server.conf filter:authtoken paste.filter_factory 'keystonemiddleware.auth_token:filter_factory'
crudini --set /etc/swift/proxy-server.conf filter:authtoken www_authenticate_uri http://controller:5000
crudini --set /etc/swift/proxy-server.conf filter:authtoken auth_url http://controller:5000
crudini --set /etc/swift/proxy-server.conf filter:authtoken memcached_servers controller:11211
crudini --set /etc/swift/proxy-server.conf filter:authtoken auth_type password
crudini --set /etc/swift/proxy-server.conf filter:authtoken project_domain_id default
crudini --set /etc/swift/proxy-server.conf filter:authtoken user_domain_id default
crudini --set /etc/swift/proxy-server.conf filter:authtoken project_name service
crudini --set /etc/swift/proxy-server.conf filter:authtoken username swift
crudini --set /etc/swift/proxy-server.conf filter:authtoken password openstack
crudini --set /etc/swift/proxy-server.conf filter:authtoken delay_auth_decision True

# Configuration de l'emplacement memcached
crudini --set /etc/swift/proxy-server.conf filter:cache use 'egg:swift#memcache'
crudini --set /etc/swift/proxy-server.conf filter:cache memcache_servers controller:11211
