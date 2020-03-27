from flask import jsonify, Response, request
from settings import app
import json

@app.route('/user', methods=['GET'])
def get_users():
    return Response(json.dumps({
        'error': 'Route requires filter like phone_number or id'}),
                    status=200, mimetype='application/json')

if __name__ == "__main__":
    app.run(host='127.0.0.1')
