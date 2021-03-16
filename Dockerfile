FROM alpine:3.11 as base

RUN apk add curl

RUN apk add python3

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

COPY . .

RUN pip3 install flask

RUN source $HOME/.poetry/env && poetry update && poetry install

RUN pip3 install gunicorn

RUN pip3 install requests

FROM base as production
ENV FLASK_ENV=production
ENTRYPOINT ["gunicorn", "app:app"]
CMD ["--config gunicorn.conf.py"]

FROM base as development
RUN poetry install
ENTRYPOINT [ "poetry", "run", "flask", "run", "-h", "0.0.0.0", "-p", "5000" ]