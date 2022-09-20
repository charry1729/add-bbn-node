
PUBLIC_KEYS_DIR=${BESU_PUBLIC_KEY_DIRECTORY:=/opt/besu/public-keys/}
BOOTNODE_KEY_FILE="${PUBLIC_KEYS_DIR}bootnode_pubkey"

rm -rf /opt/besu/database

/opt/besu/bin/besu $@ public-key export --to="${BOOTNODE_KEY_FILE}"

p2pip=`awk 'END{print $1}' /etc/hosts`

# run bootnode with discovery but no bootnodes as it's our bootnode.
/opt/besu/bin/besu $@ --bootnodes --p2p-host=$p2pip

