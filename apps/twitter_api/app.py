from flask import jsonify, Response, request
from settings import app
import json
from settings import data

@app.route('/user', methods=['GET'])
def get_users():
    if 'order' in request.args:
        order_filter = request.args.get("order")
        if order_filter == "followers":
            data['users'].sort(key=lambda x: len(x['followers']), reverse=True)
            return Response(
                json.dumps(data), status=200, mimetype='application/json')
    elif len(request.args) == 0:
        response_data = data['users']
        return Response(
            response_data, status=200, mimetype='application/json')
    return Response(
        json.dumps({}), status=204, mimetype='application/json')

if __name__ == "__main__":
    app.run(host='127.0.0.1')
