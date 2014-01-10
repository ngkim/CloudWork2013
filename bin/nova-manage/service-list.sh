#!/bin/bash

nova-manage service list 2>&1 | grep -v DEBUG
