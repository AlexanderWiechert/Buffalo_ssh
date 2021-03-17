#!/bin/sh
# This script executes different commands on the NAS, and requires two arguments to the shell script
# 1.  The IP of the NAS system
# 2.  A password for the "admin" user.



IPADDR=10.16.0.60

ADMIN_PASSWORD=anfang

java -jar acp_commander.jar  -q -t ${IPADDR} -ip ${IPADDR} -pw ${ADMIN_PASSWORD} -c $1
