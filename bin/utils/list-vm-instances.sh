#!/bin/bash

# Load variables
export OS_AUTH_URL=http://10.10.10.51:5000/v2.0
export OS_TENANT_NAME="project_one"
export OS_USERNAME=user_one
export OS_PASSWORD=user_one

nova list | awk '{print $4, $8}'


