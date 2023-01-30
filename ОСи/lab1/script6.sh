#!/bin/bash

grep "status" /var/log/dpkg.log | sed "s/status/State: /" > full.log
grep "configure" /var/log/dpkg.log | sed "s/configure/Configuration: /" >> full.log
