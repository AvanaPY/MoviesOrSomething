from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
import requests
from utils import get_from_api, render_template_m

movies = Blueprint('movies', __name__, template_folder='templates')

@movies.route('/movies', defaults={'page': 'movies'})
def index(page):
    status, content = get_from_api('/movies')
    if status != 200:
        abort(500)
    return render_template_m(f'movies/{page}.html', movies=content.get('data'))
        
@movies.route('/movies/<id>')
def movies_id(id):
    status, content = get_from_api(f'/movies/get/{id}', params="detailed=true")
    if status != 200:
        abort(404)
    return render_template_m(f'movies/movie.html', movie=content.get('data'))