from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
import requests

homepage = Blueprint('homepage', __name__, template_folder='templates')

@homepage.route('/', defaults={'page': 'homepage'})
def index(page):
    try:
        return render_template(f'homepage/{page}.html')
    except TemplateNotFound as e:
        abort(404)