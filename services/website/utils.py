from typing import Dict, Union, Tuple
from flask import render_template, abort
from jinja2 import TemplateNotFound
import requests
import os

API_URL = os.environ.get('API_URI', '127.0.0.1')
API_PORT = os.environ.get('API_PORT', '4000')
API_URI = f'http://{API_URL}:{API_PORT}/api'

def get_from_api(api_path : str, params : str = '') -> Tuple[int, Dict[str, Union[str, int, float]]]:
    if not api_path.startswith('/'): 
        raise ValueError(f'`api_path` must start with /')
    url = f'{API_URI}{api_path}?{params}'
    resp = requests.get(url)
    if resp.status_code == 404:
        return 404, resp.content.decode('utf-8')
    return 200, resp.json()

def render_template_m(template_name, *args, **kwargs) -> str:
    try:
        return render_template(template_name, *args, **kwargs)
    except TemplateNotFound:
        abort(404)