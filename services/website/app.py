from typing import Dict, Any
import flask
from flask import Flask
import blueprints
import os

def create_app(config : Dict[str, Any]) -> Flask:
    app = Flask(__name__, static_url_path='', static_folder='static', template_folder='templates')
    app.config.update(config)
    app.config['SECRET_KEY'] = os.urandom(12).hex()
    return app
    
def main():
    config = {
        'DEBUG': True
    }
    app = create_app(config)
    
    blueprints.register_blueprints(app)
    app.run()

if __name__ == '__main__':
    main()