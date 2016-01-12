#!/bin/bash
set -e
set -u

echo "Running base playbook..."
ansible-playbook -i hosts/localmesos-cluster --user=vagrant --ask-pass ../../ansible/base.yml
vagrant reload

echo "Running initial-cluster..."
ansible-playbook -i hosts/localmesos-cluster --user=vagrant --ask-pass --extra-vars="mesos_cluster_name=localcluster-on-`hostname` mesos_master_network_interface=ansible_eth1 mesos_slave_network_interface=ansible_eth1" ../../ansible/initial-cluster.yml
