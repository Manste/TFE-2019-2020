crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_suffix openstack
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_prefix openstack

crudini --set /etc/swift/swift.conf storage-policy:0 name Policy-0
crudini --set /etc/swift/swift.conf storage-policy:0 default yes
