from .homepage import homepage
from .movies import movies
from .actors import actors

def register_blueprints(app):
    app.register_blueprint(homepage)
    app.register_blueprint(movies)
    app.register_blueprint(actors)