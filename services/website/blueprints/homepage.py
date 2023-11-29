from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
import requests

homepage = Blueprint('homepage', __name__, template_folder='templates')

@homepage.route('/', defaults={'page': 'homepage'})
def index(page):
    a = requests.get('http://localhost:4000/api/movies').json()
    print(a)
    try:
        return render_template(f'homepage/{page}.html')
    except TemplateNotFound as e:
        print(e)
        abort(404)