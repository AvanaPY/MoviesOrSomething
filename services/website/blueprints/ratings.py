from flask import Blueprint, render_template, abort
from jinja2 import TemplateNotFound
from utils import get_from_api, render_template_m
import requests

ratings = Blueprint('ratings', __name__, template_folder='templates')

@ratings.route('/ratings', defaults={'page': 'ratings'})
def index(page):
    return render_template_m(f'ratings/{page}.html')