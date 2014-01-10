#!/bin/bash

umount $MNG_ROOT
mount -t nfs4 211.224.204.158:/ $MNG_ROOT
