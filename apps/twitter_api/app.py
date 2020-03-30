from flask import jsonify, Response, request
from settings import app
import json
from datetime import datetime
from settings import data
from copy import deepcopy

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
    return Response("", status=422, mimetype='application/json')

@app.route('/post', methods=['GET'])
def get_posts():
    data_copy = deepcopy(data)
    if ("from" in request.args and "to" in request.args) \
            or "tag" in request.args or "lang" in request.args:
        for user_index, user_value in reversed(list(enumerate(data_copy['users']))):
            for post_index, post_value in reversed(list(enumerate(data_copy['users'][user_index]['posts']))):
                if "from" in request.args and "to" in request.args:
                    from_time = datetime.fromtimestamp(int(request.args.get("from")))
                    to_time = datetime.fromtimestamp(int(request.args.get("to")))
                    post_date = post_value['date'].split(" GMT")[0]
                    post_date = datetime.strptime(post_date, "%a %b %d %Y %H:%M:%S")

                    if not from_time < post_date < to_time:
                        del data_copy['users'][user_index]['posts'][post_index]
                        if len(data_copy['users'][user_index]['posts']) == 0:
                            del data_copy['users'][user_index]
                if "tag" in request.args:
                    tag = request.args.get("tag")
                    if tag not in post_value['tags']:
                        del data_copy['users'][user_index]['posts'][post_index]
                        if len(data_copy['users'][user_index]['posts']) == 0:
                            del data_copy['users'][user_index]
        if "lang" in request.args:
            for user_index, user_value in reversed(list(enumerate(data_copy['users']))):
                if user_value['language'] != request.args.get('lang'):
                    del data_copy['users'][user_index]
        return Response(json.dumps(data_copy), status=200, mimetype="application/json")
    if len(request.args) > 0:
        return Response("", status=501, mimetype='application/json')
    return Response("", status=422, mimetype='application/json')


if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080)
