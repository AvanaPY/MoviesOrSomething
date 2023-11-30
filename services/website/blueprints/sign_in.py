from flask import Blueprint, render_template, abort, request, redirect, session
from jinja2 import TemplateNotFound
from utils import get_from_api, render_template_m
import requests

signin = Blueprint('signin', __name__, template_folder='templates')

@signin.route('/signin', defaults={'page': 'signin'})
def index(page):
    return render_template_m(f'signin/{page}.html')

@signin.route('/signin/submit', methods=['POST'])
def signin_submit() -> str:
    username = request.form.get('user')
    password = request.form.get('password')
    
    if not username or not password:
        session['empty-credentials'] = True
        return redirect('/signin')
    
    if request.form['action'] == 'register':
        return _register(username, password)
    else:
        return _signin(username, password)

def _register(username : str, password : str) -> str:
    json = {
        "user" : {
            "username" : username,
            "password" : password
        }
    }
    status, result = get_from_api('/user/create', json=json, method="POST")
    if status == 200 or status == 201:
        result = result.get('data')
        session['username'] = result.get('username')
        session['token'] = result.get('token')
        return redirect('/')
    elif status == 409:
        session['username-taken'] = True
        return redirect('/signin')
    else:
        print(f'Internal Server Error: {status} ({result})')
        abort(500)

def _signin(username : str, password: str) -> str:

    status, result = get_from_api('/user/authenticate', f'username={username}&password={password}')
    if status == 404:
        session['invalid-credentials'] = True
        return redirect(f'/signin')
    
    result = result.get('data')
    session['username'] = result.get('username')
    session['token'] = result.get('token')
    return redirect('/')

@signin.route('/signin/logout')
def signin_logout() -> str:
    session['username'] = None
    session['token'] = None
    return redirect('/')