#!/bin/bash

alias pythonserver='python3 -m http.server 50080'
alias quicklookkill='killall -9 QuickLookUIService'
alias flushdns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'
alias aerei='view1090 --net-bo-ipaddr piradar --aggressive --fix'
alias proxyserver='ssh -D 1080 -qCN server.fqdn'
alias testnet="ping 1.1.1.1"
