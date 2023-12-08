#!/bin/bash

IF="en0"
HOSTID="::1984"

###

base=`ifconfig $IF | grep "autoconf secured" | cut -d ' ' -f2 | cut -d ':' -f1-4` # 1-4 => /64
newip="$base$HOSTID"
echo -e "Adding $newip:\n"
ifconfig $IF inet6 $newip

# proof
ifconfig $IF
