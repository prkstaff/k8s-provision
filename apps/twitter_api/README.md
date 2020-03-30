# API APPLICATION

## Requirements:
- Python3 
- Pip3
- Mac or Linux

## Install:
Setup virtualenv(optional):
```bash
python3 -m venv venv
source venv/bin/activate
```

Install pip requirements:
```bash
pip install -r requirements.dev.txt
```

## Running the application:
Activate the virtualenv(if you are using it)
```bash
source venv/bin/activate
```

```bash
FLASK_APP=app.py python app.py
```

## Running the tests
If dev dependencies are not installed, install it
```bash
pip install requirements.dev.txt
```

Activate the virtualenv(if you are using it)
```bash
source venv/bin/activate
```

```bash
nosetests
```
## Docker

### Building the image
```
docker build . -t case-interview-api
```

### Pushing the image
```
docker tag case-interview-api:<new-version>
docker push <company-docker-hub-uri>/case-interview-api:<new-version>
```
