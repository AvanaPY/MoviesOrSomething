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
    
    movies = content.get('data')
    movies = sorted(movies, key=lambda m : m.get("title"))
    
    return render_template_m(f'movies/{page}.html', movies=movies)
        
@movies.route('/movies/<id>')
def movies_id(id):
    status, content = get_from_api(f'/movies/get/{id}', params="detailed=true")
    if status != 200:
        abort(404)
    
    movie = content.get('data')
    ratings = movie.get('ratings')
    average_rating = round(sum(map(lambda x : x['rating'], ratings)) / len(ratings), 2) if len(ratings) > 0 else 0
    
    movie['average_rating'] = average_rating
    return render_template_m(f'movies/movie.html', movie=movie)