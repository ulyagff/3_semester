#!/bin/bash

grep -E -h -s -o -w "(([[:alnum:]_.]+)@([[:alnum:]_\.\-]+)\.([a-zA-Z]+)" /etc/* | awk '{printf("%s, ",$1)}' > emails.txt