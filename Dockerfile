FROM python:3.9-alpine as base

RUN apk add curl

ENV POETRY_HOME=/poetry
ENV PATH=${POETRY_HOME}/bin:${PATH}

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

COPY . .

RUN poetry update && poetry install

FROM base as production
ENV FLASK_ENV=production
ENTRYPOINT ["gunicorn", "app:app"]
CMD ["--config gunicorn.conf.py"]

FROM base as development

RUN poetry config virtualenvs.create false --local && poetry install
ENTRYPOINT [ "poetry", "run", "flask", "run", "-h", "0.0.0.0", "-p", "5000" ]