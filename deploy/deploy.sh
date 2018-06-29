#!//bin/sh -ex
PASSWORD=${1:-ansible}
INVENTORY=${2:-development}
PLAYBOOK=${3:-site.yml}
shift 3
other_args=${@}

# TODO: For offline sceanrios, roles should be added to SCM
#ansible-galaxy install -r requirements.yml
sshpass -p ${PASSWORD} ansible-playbook -i inventories/${INVENTORY} ${PLAYBOOK} --extra-vars "ansible_become_pass=${PASSWORD}" -k ${other_args}
