import socketio
import eventlet
from flask import Flask

app = Flask(__name__)

sio = socketio.Server(cors_allowed_origins='*')

app = socketio.WSGIApp(sio, app)

authenticated_users = {}

@sio.on('connect')
def connect(sid, environ):
    print(f'Client {sid} connected')


@sio.on('login')
def login(sid, data):
    username = data.get('username')
    if username:
        authenticated_users[sid] = username
        print(f'User {username} authenticated')
    else:
        print(f'Invalid username received from {sid}')


@sio.on('message')
def message(sid, data):
    username = authenticated_users.get(sid)
    if username:
        print(f'Message from {username}: {data}')
        sio.emit('message', {'username': username, 'message': data}, skip_sid=sid)
    else:
        print(f'Unauthorized message received from {sid}')


@sio.on('disconnect')
def disconnect(sid):
    if sid in authenticated_users:
        username = authenticated_users.pop(sid)
        print(f'User {username} disconnected')
    else:
        print(f'Client {sid} disconnected')

if __name__ == '__main__':
    eventlet.wsgi.server(eventlet.listen(('localhost', 5000)), app)