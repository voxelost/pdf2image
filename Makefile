.PHONY: *

default: _install run

run:
	python3 -m pipenv run python3 src/main.py

_install:
	python3 -m pip install pipenv
	python3 -m pipenv install

format:
	python3 -m pip install pipenv
	python3 -m pipenv install --dev
	python3 -m pipenv run python3 -m autoflake .
	python3 -m pipenv run python3 -m isort .
	python3 -m pipenv run python3 -m black .

docker-push:
	docker buildx build --platform linux/arm64 . --tag voxelost/pdf2image --push
