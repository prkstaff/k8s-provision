#!/bin/sh

## apply db models
#flask db upgrade

FLASK_ENV=development FLASK_APP=app.py python app.py
#gunicorn -b 0.0.0.0:8080 app:app
