from flask import Blueprint, render_template, abort, session, redirect, url_for, request
from jinja2 import TemplateNotFound
import requests
from utils import get_from_api, render_template_m

movies = Blueprint('movies', __name__, template_folder='templates')

@movies.route('/movies', defaults={'page': 'movies'})
def index(page):
    status, content = get_from_api('/movies')
    if status == 200:
        movies = content.get('data')
        movies = sorted(movies, key=lambda m : m.get("title"))
        return render_template_m(f'movies/{page}.html', movies=movies)
    else:
        return render_template_m(f'movies/{page}.html', movies=[])
        
@movies.route('/movies/<id>')
def movies_id(id):
    status, content = get_from_api(f'/movies/get/{id}', params="detailed=true")
    if status != 200:
        abort(404)
    
    movie = content.get('data')
    ratings = movie.get('ratings')
    average_rating = round(sum(map(lambda x : x['rating'], ratings)) / len(ratings), 2) if len(ratings) > 0 else 0
    
    movie['average_rating'] = average_rating
    session['movie_id'] = id
    return render_template_m(f'movies/movie.html', movie=movie)

@movies.route('/review/<movie_id>')
def movies_review(movie_id):
    status, content = get_from_api(f'/movies/get/{movie_id}', params="detailed=true")
    if status != 200:
        abort(404)
        
    if session.get('token') == None:
        return redirect(url_for('signin.index'))
    
    movie = content.get('data')
    session['movie_id'] = movie_id
    return render_template_m(f'movies/review.html', movie=movie)

@movies.route('/review/submit', methods=['POST'])
def movies_review_submit():
    movie_id = session.get('movie_id')
    
    rating  = request.form.get('rating')
    title   = request.form.get('title')
    descr   = request.form.get('description')
    user_id = 1
    
    json = {
        "movie_rating" : {
            "movie_id": movie_id,
            "rating": rating,
            "title": title,
            "description": descr,
            "user_id": user_id
        }
    }
    
    status, content = get_from_api('/movies/rating/rate', json=json, method="POST")
    if status == 201:
        return redirect(f'/movies/{movie_id}')
    return redirect('/')