#!/bin/bash
man bash | grep -o -i "[[:alnum:]]\{4,\}" | sort | uniq -i -c | sort -n -nr | head -3
Word word 