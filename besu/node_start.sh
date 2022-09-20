

PUBLIC_KEYS_DIR=${BESU_PUBLIC_KEY_DIRECTORY:=/opt/besu/public-keys/}
BOOTNODE_KEY_FILE="${PUBLIC_KEYS_DIR}bootnode_pubkey"

# sleep loop to wait for the public key file to be written
while [ ! -f "${BOOTNODE_KEY_FILE}" ]
do
  sleep 1
done

rm -rf /opt/besu/database

bootnode_pubkey=`sed 's/^0x//' ${BOOTNODE_KEY_FILE}`
boonode_ip=`getent hosts bootnode | awk '{ print $1 }'`
BOOTNODE_P2P_PORT="30303"
bootnode_enode_address="enode://${bootnode_pubkey}@${boonode_ip}:${BOOTNODE_P2P_PORT}"

p2pip=`awk 'END{print $1}' /etc/hosts`

/opt/besu/bin/besu $@ --bootnodes=$bootnode_enode_address --p2p-host=$p2pip

