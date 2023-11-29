from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
from utils import get_from_api, render_template_m
import requests

actors = Blueprint('actors', __name__, template_folder='templates')

@actors.route('/actors', defaults={'page': 'actors'})
def index(page):
    status, content = get_from_api('/actors')
    if status != 200:
        abort(500)
    return render_template_m(f'actors/{page}.html', actors=content.get('data'))

@actors.route('/actors/<id>')
def actors_id(id):
    status, content = get_from_api(f'/actors/{id}', params="detailed=true")
    print(content)
    if status != 200:
        abort(404)
    return render_template_m(f'actors/actor.html', actor=content.get('data'))