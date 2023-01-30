#!/bin/bash

awk '{if ($5 = "kernel:") print $0 > "info.log"}' /var/log/installer/syslog