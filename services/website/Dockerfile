FROM python:3.11-slim AS build

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt && \
    pip install gunicorn==21.2.0

FROM build as launch
CMD ["gunicorn", "-w", "1", "-b", "0.0.0.0:8000", "app:create_app()"]