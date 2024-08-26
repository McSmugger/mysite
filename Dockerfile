FROM python:3.12-slim

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev curl gcc python3-dev musl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install poetry

WORKDIR /app

COPY pyproject.toml poetry.lock* /app/

RUN poetry config virtualenvs.create false

RUN poetry install --only main --no-interaction --no-ansi

COPY . /app/

RUN poetry run python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["sh", "-c", "poetry run python manage.py migrate && poetry run python manage.py runserver 0.0.0.0:8000"]
