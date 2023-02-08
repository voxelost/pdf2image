# syntax=docker/dockerfile:1
FROM python:3.11-slim-bullseye
ENV PYTHONUNBUFFERED 1

EXPOSE 8000

RUN apt update && apt install -y make poppler-utils
COPY . ./

RUN make _install

CMD make run
