crudini --set /etc/swift/account-server.conf DEFAULT bind_ip 10.0.0.51
crudini --set /etc/swift/account-server.conf DEFAULT bind_port 6202
crudini --set /etc/swift/account-server.conf DEFAULT user swift
crudini --set /etc/swift/account-server.conf DEFAULT swift_dir /etc/swift
crudini --set /etc/swift/account-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/account-server.conf DEFAULT mount_check True
crudini --set /etc/swift/account-server.conf pipeline:main pipeline 'healthcheck recon account-server'
crudini --set /etc/swift/account-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/account-server.conf filter:recon recon_cache_path /var/cache/swift

crudini --set /etc/swift/container-server.conf DEFAULT bind_ip 10.0.0.51
crudini --set /etc/swift/container-server.conf DEFAULT bind_port 6201
crudini --set /etc/swift/container-server.conf DEFAULT user swift
crudini --set /etc/swift/container-server.conf DEFAULT swift_dir /etc/swift
crudini --set /etc/swift/container-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/container-server.conf DEFAULT mount_check True
crudini --set /etc/swift/container-server.conf pipeline:main pipeline 'healthcheck recon container-server'
crudini --set /etc/swift/container-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/container-server.conf filter:recon recon_cache_path /var/cache/swift

crudini --set /etc/swift/object-server.conf DEFAULT bind_ip 10.0.0.51
crudini --set /etc/swift/object-server.conf DEFAULT bind_port 6200
crudini --set /etc/swift/object-server.conf DEFAULT user swift
crudini --set /etc/swift/object-server.conf DEFAULT swift_dir /etc/swift
crudini --set /etc/swift/object-server.conf DEFAULT devices /srv/node
crudini --set /etc/swift/object-server.conf DEFAULT mount_check True
crudini --set /etc/swift/object-server.conf pipeline:main pipeline 'healthcheck recon object-server'
crudini --set /etc/swift/object-server.conf filter:recon use 'egg:swift#recon'
crudini --set /etc/swift/object-server.conf filter:recon recon_cache_path /var/cache/swift
crudini --set /etc/swift/object-server.conf filter:recon recon_lock_path /var/lock

