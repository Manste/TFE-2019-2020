# Configuration du préfixe et du suffixe du chemin de hachage pour 
# notre environnement
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_suffix openstack
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_prefix openstack

# Configuration de la stratégie de stockage par défaut
crudini --set /etc/swift/swift.conf storage-policy:0 name Policy-0
crudini --set /etc/swift/swift.conf storage-policy:0 default yes
