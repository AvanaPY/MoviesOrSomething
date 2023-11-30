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
    app.config['SECRET_KEY'] = os.urandom(12).hex()
    
    blueprints.register_blueprints(app)
    return app
    
def main():
    app = create_app()
    app.run()

if __name__ == '__main__':
    main()