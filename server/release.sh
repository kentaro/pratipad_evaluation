#!/bin/sh

set -eu

MIX_ENV=prod mix release pratipad_example_server
scp release/*.tar.gz pi@172.16.0.129:/app
ssh pi@172.16.0.129 -- cd /app && tar zxvf *.tar.gz && rm -rf *.tar.gz
rm -rf release/*
