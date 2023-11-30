from flask import Blueprint, render_template, abort, request, redirect, session
from jinja2 import TemplateNotFound
from utils import get_from_api, render_template_m
import requests

signin = Blueprint('signin', __name__, template_folder='templates')

@signin.route('/signin', defaults={'page': 'signin'})
def index(page):
    return render_template_m(f'signin/{page}.html')

@signin.route('/signin/submit')
def signin_submit() -> str:
    username = request.args.get('user')
    password = request.args.get('password')
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