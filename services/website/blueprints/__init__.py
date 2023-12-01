from .homepage import homepage
from .movies import movies
from .actors import actors
from .sign_in import signin
from .ratings import ratings

def register_blueprints(app):
    app.register_blueprint(homepage)
    app.register_blueprint(movies)
    app.register_blueprint(actors)
    app.register_blueprint(signin)