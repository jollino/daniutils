#!/bin/bash

IF=en0
HOSTID=::1984

###

tmpfile=`mktemp`

ifconfig $IF > $tmpfile
base=`grep "autoconf secured" $tmpfile | cut -d ' ' -f2 | cut -d ':' -f1-4` # 1-4 => /64
newip="$base$HOSTID"
ifconfig $IF inet6 $newip

# proof
ifconfig $IF

rm $tmpfile