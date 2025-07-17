#!/usr/bin/python

import configparser
import os

config = configparser.ConfigParser()

# Build path relative to the script's directory
config_path = os.path.join(os.path.dirname(__file__), 'config/config.ini')
config.read(config_path)

print("Sections found:", config.sections())

host = config['flask-server']['host']
port = config.getint('flask-server', 'port')
print(f"Flask App Server Host: {host}, Port: {port}")
