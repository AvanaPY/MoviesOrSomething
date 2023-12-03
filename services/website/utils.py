from typing import Dict, Union, Tuple
from flask import render_template, abort
from jinja2 import TemplateNotFound
import requests
import os

API_URL = os.environ.get('API_URI', '127.0.0.1')
API_PORT = os.environ.get('API_PORT', '4000')

API_URI = f'http://{API_URL}:{API_PORT}/api'

try:    
    resp = requests.get(API_URI)
    if resp.status_code == 200:
        print(f'API Service online: Received {resp.content.decode()}')
    else:
        print(f'API Service online: However received status code {resp.status_code}')
except requests.exceptions.ConnectionError:
    print(f'API Service not available at {API_URI}')
    exit(0)

def get_from_api(api_path : str, 
                 params : str = '', 
                 json : dict = None,
                 method : str = "GET") -> Tuple[int, Dict[str, Union[str, int, float]]]:
    if not api_path.startswith('/'): 
        raise ValueError(f'`api_path` must start with /')
    
    url = f'{API_URI}{api_path}{"?" if params else ""}{params}'
    
    if method == "GET":
        resp = requests.get(url, json=json)
    elif method == "POST":
        resp = requests.post(url, json=json)
    else:
        raise RuntimeError(f'Invalid Method: {method}')

    if resp.status_code == 500:
        return resp.status_code, "Service not available"
    elif resp.status_code == 404:
        return resp.status_code, resp.content.decode('utf-8')
        
    try:
        return resp.status_code, resp.json()
    except:
        return resp.status_code, resp.content.decode()

def render_template_m(template_name, *args, **kwargs) -> str:
    try:
        return render_template(template_name, *args, **kwargs)
    except TemplateNotFound:
        abort(404)