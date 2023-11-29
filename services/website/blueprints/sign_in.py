from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
from utils import get_from_api, render_template_m
import requests

signin = Blueprint('signin', __name__, template_folder='templates')

@signin.route('/signin', defaults={'page': 'signin'})
def index(page):
    return render_template_m(f'signin/{page}.html')