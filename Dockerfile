FROM alpine:3.11

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

COPY . .

ENTRYPOINT [ "" ]