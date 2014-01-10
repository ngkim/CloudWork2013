#!/bin/bash

sysctl -w net.ipv4.tcp_max_syn_backlog=30000
sysctl -w net.ipv4.tcp_max_tw_buckets=2000000
sysctl -w net.core.netdev_max_backlog=50000
sysctl -w net.ipv4.tcp_window_scaling=1
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
sysctl -w net.ipv4.tcp_wmem="4096 87380 16777216"
sysctl -w net.ipv4.tcp_congestion_control=cubic
sysctl -w vm.swappiness=0
sysctl -w net.ipv4.tcp_syncookies=1
