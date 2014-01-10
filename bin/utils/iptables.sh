#!/bin/bash

ITF_OUT=em1
ITF_IN=p1p1
LOCAL_SBNET=50.50.1.0/24

iptables -A FORWARD -o $ITF_OUT -i $ITF_IN -s 50.50.1.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o $ITF_OUT -j MASQUERADE

