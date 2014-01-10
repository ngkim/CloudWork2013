#!/bin/bash

ITF=eth0
MAC_ADDR=`ifconfig $ITF | grep HWaddr | awk '{print $5}'`

ifconfig $ITF hw ether $MAC_ADDR up
