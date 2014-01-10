#!/bin/bash

# from local file
glance image-create --name ubuntu-server-12.04-64bit --is-public true  --container-format bare --disk-format qcow2 --file ../../precise-server-cloudimg-amd64-disk1.img
