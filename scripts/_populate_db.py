from typing import List, Tuple, Optional
import requests
from dataclasses import dataclass
import random
import gc

random.seed(42)

URI = 'http://localhost:4000/api'

try:    
    resp = requests.get(URI)
    assert resp.status_code == 200, f'Received status {resp.status_code} from API'
    print(f'API Service available: {resp.content.decode()}')
except requests.exceptions.ConnectionError:
    print(f'API Service not available at {URI}')
    exit(0)

@dataclass
class Actor:
    name: str
    last_name: str
    age: int
    country: str
    year_started: int  
    def json(self) -> dict:
        return {
            "actor": {
                "name" : self.name,
                "last_name": self.last_name,
                "age": self.age,
                "country": self.country,
                "year_started": self.year_started
            }
        }
        
@dataclass
class Movie:
    title: str
    tagline: str
    length_minutes: int
    director: str
    language: str
    budget: int
    box_office: int
    release_year: int
    actors : List[Tuple[Actor, str]]
    m_id: Optional[int] = None
    def json(self) -> dict:
        return {	
            "movie" : {
                "title": self.title,
                "tagline": self.tagline,
                "length_minutes": self.length_minutes,
                "director": self.director,
                "language": self.language,
                "budget": self.budget,
                "box_office" : self.box_office,
                "release_year": self.release_year
            }
        }
        
@dataclass
class Rating:
    movie_id: int
    user_id: int
    rating: int
    title: str
    description: str
    def json(self) -> dict:
        return {
            "movie_rating": {
                "movie_id": self.movie_id,
                "user_id": self.user_id,
                "rating": self.rating,
                "title": self.title,
                "description": self.description
            }
        }

# Start by setting up two default users with a default password
users = [
    {
        "user" : {
            "username": "username",
            "password": "password"
        }  
    },
    {
        "user" : {
            "username": "username1",
            "password": "password2"
        }  
    },
]

for json in users:
    resp = requests.post(f'{URI}/user/create', json=json)
    if resp.status_code == 201:
        print(f'User created succesfully')
    elif resp.status_code == 409:
        print(f'User already exists, moving on')
    else:
        print(f'Failed to create user: {resp.content.decode()} ({resp.status_code})')
        exit(0)

# Then some actors and movies

leonardo = Actor(name="Leonardo",
                 last_name="DiCaprio",
                 age=47,
                 country="USA",
                 year_started=1989)
cillian = Actor(name="Cillian",
        last_name="Murphy",
        age=47,
        country="Ireland",
        year_started=1996)


matthew = Actor(name="Matthew",
        last_name="McConaughey",
        age=54,
        country="USA",
        year_started=1991)
anne = Actor(name="Anne",
             last_name="Hathaway",
             age=41,
             country="USA",
             year_started=1999)

timothee = Actor(name="Timothée",
                 last_name="Chalamet",
                 age=27,
                 country="USA",
                 year_started=2007)
zendaya = Actor(name="Zendaya",
                last_name="Coleman",
                age=27,
                country="USA",
                year_started=2009)

angelina = Actor(name="Angelina",
        last_name="Jolie",
        age=48,
        country="USA",
        year_started=1982)
jonny = Actor(name="Jonny",
        last_name="Miller",
        age=51,
        country="UK",
        year_started=1982)


sam = Actor(name="Sam",
        last_name="Worthington",
        age=47,
        country="UK",
        year_started=2000)
zoe = Actor(name="Zoe",
            last_name="Saldaña",
            age=45,
            country="USA",
            year_started=1999)

mark = Actor(name="Mark",
        last_name="Hamill",
        age=72,
        country="USA",
        year_started=1970)

actors = [
    obj for obj in gc.get_objects() if isinstance(obj, Actor)
]

for actor in actors:
    resp = requests.post(f'{URI}/actors/create', json=actor.json())
    print(f'Created movie {actor.name}: {resp.status_code}')
    
actors_index = requests.get(f'{URI}/actors').json().get('data')

movies = [
    Movie(
        title="Inception",
        tagline="About dreams!",
        length_minutes=148,
        director="Christopher Nolan",
        language="EN",
        budget=160,
        box_office=839,
        release_year=2010,
        actors=[(cillian, "Fischer"), (leonardo, "Cobb")]),
    Movie(
        title="Dune",
        tagline="About!!",
        length_minutes=155,
        director="Denis Villeneuve",
        language="EN",
        budget=165,
        box_office=402,
        release_year=2021,
        actors=[(timothee, "Paul"), (zendaya, "Chani")]),
    Movie(
        title="Interstellar",
        tagline="About Space!!",
        length_minutes=148,
        director="Christopher Nolan",
        language="EN",
        budget=160,
        box_office=839,
        release_year=2010,
        actors=[(matthew, "Cooper"), (anne, "Brand")]),
    Movie(
        title="Hackers",
        tagline="Not really sure!",
        length_minutes=105,
        director="Iain",
        language="EN",
        budget=20,
        box_office=8,
        release_year=1995,
        actors=[(jonny, "Dade"), (angelina, "Kate")]),
    Movie(
        title="Avatar",
        tagline="Let's go blue people!",
        length_minutes=162,
        director="James Cameron",
        language="EN",
        budget=237,
        box_office=2923,
        release_year=2009,
        actors=[(sam, "Jake Sully"), (zoe, "Neytiri")]),
    Movie(
        title="Avatar: The Way of Water",
        tagline="Let's go blue people again!",
        length_minutes=192,
        director="James Cameron",
        language="EN",
        budget=350,
        box_office=2320,
        release_year=2022,
        actors=[(sam, "Jake Sully"), (zoe, "Neytiri")]) 
]

rating_titles = [
    "Really Good Movie!", 
    "Movie may be better than it appears...",
]

rating_descriptions = [
    "The Movie was very good! I am just blown away by the quality of this!",
    "It's a non-stop cheeze-fest of events but it's really good! You'll be surprised at the quality of this!"
]

rating_ratings = list(range(5, 11))

for movie in movies:
    resp = requests.post(f'{URI}/movies/create', json=movie.json())
    print(f'Created movie {movie.title}: {resp.status_code}')
    
    for actor, character in movie.actors:
        json = {
            "movie_name": movie.title,
            "actor_name": f'{actor.name} {actor.last_name}',
            "movie_actor": {
                "character_name": character
            }
        }
        resp = requests.post(f'{URI}/movies/actors/create', json=json)
        print(f'Creating movie_character {movie.title}/{actor.name}: {resp.status_code}')
        if resp.status_code == 200 and movie.m_id == None:
            json = resp.json()
            movie.m_id = json.get('data').get('movie')
    
    users = random.sample(range(1, 3), k=random.randint(1, 2))
    for i in users:
        rating = Rating(
            movie_id=movie.m_id,
            user_id=i,
            rating=random.choice(rating_ratings),
            title=random.choice(rating_titles),
            description=random.choice(rating_descriptions)
        )
        resp = requests.post(f'{URI}/movies/rating/rate', json=rating.json())
        if resp.status_code == 201:
            print(f'Created review for {movie.title}: {rating.title}')
        else:
            print(f'Failed to create movie review: {resp.content.decode()} ({rating.json()})')