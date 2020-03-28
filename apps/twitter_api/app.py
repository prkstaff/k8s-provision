from flask import jsonify, Response, request
from settings import app
import json
from settings import data

@app.route('/user', methods=['GET'])
def get_users():
    return Response(
        data, status=200, mimetype='application/json')

if __name__ == "__main__":
    app.run(host='127.0.0.1')
