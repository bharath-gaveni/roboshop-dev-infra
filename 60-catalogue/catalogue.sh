#!/bin/bash
component=$1
environment=$2
dnf install ansible -y
REPO_URL=https://github.com/bharath-gaveni/ansible-roboshop-roles.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles


mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop
touch /var/log/roboshop/ansible.log

cd $REPO_DIR

if [ -d $ANSIBLE_DIR ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi    

ansible-playbook -e component=$component -e env=$environment main.yaml

