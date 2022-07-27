#!/usr/bin/env python

#This script helps to get last stable version of flutter SDK

from urllib.request import urlopen
import json

with urlopen('https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json') as f:
        releases_linux_raw = f.read().decode('utf-8').strip()
        releases_linux_json = json.loads(releases_linux_raw)
        flutter_sdk_tag = releases_linux_json["current_release"]["stable"]
        print(flutter_sdk_tag)
