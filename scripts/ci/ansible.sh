#!/bin/bash
set -e

ansible-playbook -i generated/inventory.ini ansible/site.yml
