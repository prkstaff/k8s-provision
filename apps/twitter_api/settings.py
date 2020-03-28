from flask import Flask
import logging
import sys
import os
import json

# Logging
logger = logging.getLogger('flask')
sh = logging.StreamHandler(sys.stdout)
logger_level = logging.DEBUG if os.getenv("FLASK_ENV") == "development" else logging.INFO
logger.setLevel(logger_level)
logger.addHandler(sh)

# App
app = Flask(__name__)

try:
    with open("data.json", 'r') as f:
        data = json.load(f)
except IOError:
    print("File not accessible")
finally:
    f.close()
