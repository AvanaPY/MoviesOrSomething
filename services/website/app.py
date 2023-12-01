from typing import Dict, Any
import flask
from flask import Flask
import blueprints
import os

def create_app() -> Flask:
    app = Flask(__name__, static_url_path='', static_folder='static', template_folder='templates')
    
    config = {
        'DEBUG': True
    }
    
    app.config.update(config)
    app.config['SECRET_KEY'] = 'b642f77824eab51bca372b3a'
    app.config['SESSION_COOKIE_NAME'] = 'my_cookie_session'
    
    blueprints.register_blueprints(app)
    return app
    
def main():
    app = create_app()
    app.run()

if __name__ == '__main__':
    main()