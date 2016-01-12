#!/bin/bash
set -e
set -u

echo "Kernel reload()..."
ansible-playbook -i hosts/single --user=vagrant --private-key='.vagrant/machines/localmesos01/virtualbox/private_key' ../../ansible/base.yml
vagrant reload

echo "Starting ansible-playbook to set up other services..."

ansible-playbook -i hosts/single --user=vagrant --private-key='.vagrant/machines/localmesos01/virtualbox/private_key' --extra-vars="mesos_cluster_name=localcluster-on-`hostname` mesos_master_network_interface=ansible_eth1 mesos_slave_network_interface=ansible_eth1" ../../ansible/initial-cluster.yml
