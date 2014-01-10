#!/bin/bash

vmstat -n 1 | awk '{ us=$13; sy=$14; sum=us+sy; printf("%5d %5s %5s\n", sum, $13, $14);}'
