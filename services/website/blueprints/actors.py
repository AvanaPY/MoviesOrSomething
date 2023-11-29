from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
import requests

actors = Blueprint('actors', __name__, template_folder='templates')

@actors.route('/actors', defaults={'page': 'actors'})
def index(page):
    a = requests.get('http://localhost:4000/api/actors').json()
    try:
        print(a)
        return render_template(f'actors/{page}.html', actors=a.get('data'))
    except TemplateNotFound as e:
        abort(404)