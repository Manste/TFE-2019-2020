# Définir l'adresse IP de liaison
crudini --set /etc/swift/account-server.conf DEFAULT bind_ip 10.0.0.51

# Définir le port de liaison
crudini --set /etc/swift/account-server.conf DEFAULT bind_port 6202

# Définir l'utilisateur
crudini --set /etc/swift/account-server.conf DEFAULT user swift

# Définir le répertoire de configuration de swift
crudini --set /etc/swift/account-server.conf DEFAULT swift_dir /etc/swift

# Définir le répertoire du point de montage
crudini --set /etc/swift/account-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/account-server.conf DEFAULT mount_check True

# Activer les modules appropriés
crudini --set /etc/swift/account-server.conf pipeline:main pipeline 'healthcheck recon account-server'

# Configuration du répertoire cache 
crudini --set /etc/swift/account-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/account-server.conf filter:recon recon_cache_path /var/cache/swift

#****************************************************

# Définir l'adresse IP de liaison
crudini --set /etc/swift/container-server.conf DEFAULT bind_ip 10.0.0.51

# Définir le port de liaison
crudini --set /etc/swift/container-server.conf DEFAULT bind_port 6201

# Définir l'utilisateur
crudini --set /etc/swift/container-server.conf DEFAULT user swift

# Définir le répertoire de configuration de swift
crudini --set /etc/swift/container-server.conf DEFAULT swift_dir /etc/swift

# Définir le répertoire du point de montage
crudini --set /etc/swift/container-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/container-server.conf DEFAULT mount_check True

# Activer les modules appropriés
crudini --set /etc/swift/container-server.conf pipeline:main pipeline 'healthcheck recon container-server'

# Configuration du répertoire cache 
crudini --set /etc/swift/container-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/container-server.conf filter:recon recon_cache_path /var/cache/swift

#*******************************************************

# Définir l'adresse IP de liaison
crudini --set /etc/swift/object-server.conf DEFAULT bind_ip 10.0.0.51

# Définir le port de liaison
crudini --set /etc/swift/object-server.conf DEFAULT bind_port 6200

# Définir l'utilisateur
crudini --set /etc/swift/object-server.conf DEFAULT user swift

# Définir le répertoire de configuration de swift
crudini --set /etc/swift/object-server.conf DEFAULT swift_dir /etc/swift

# Définir le répertoire du point de montage
crudini --set /etc/swift/object-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/object-server.conf DEFAULT mount_check True

# Activer les modules appropriés
crudini --set /etc/swift/object-server.conf pipeline:main pipeline 'healthcheck recon object-server'

# Configuration du répertoire cache de reconnaissance
crudini --set /etc/swift/object-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/object-server.conf filter:recon recon_cache_path /var/cache/swift

# Configuration du répertoire de vérrouillage 
crudini --set /etc/swift/object-server.conf filter:recon recon_lock_path /var/lock

