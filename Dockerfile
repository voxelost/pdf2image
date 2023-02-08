FROM python:3.11-slim-bullseye
ENV PYTHONUNBUFFERED 1

RUN apt update && apt install -y make
COPY . ./

RUN make _install

CMD make
