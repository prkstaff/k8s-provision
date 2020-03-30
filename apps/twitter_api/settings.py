from flask import Flask
import logging
import sys
import os
import json
from log import StackdriverJsonFormatter

# Logging
handler = logging.StreamHandler(sys.stdout)
formatter = StackdriverJsonFormatter()
handler.setFormatter(formatter)
logger = logging.getLogger()
logger.addHandler(handler)
logger_level = logging.DEBUG if os.getenv("FLASK_ENV") == "development" else logging.INFO
logger.setLevel(logger_level)


# App
app = Flask(__name__)

try:
    with open("data.json", 'r') as f:
        data = json.load(f)
except IOError:
    print("File not accessible")
finally:
    f.close()
