.PHONY: *

deploy:
	python3 -m pipenv run python3 -m gunicorn src.main

_install:
	python3 -m pip install pipenv
	python3 -m pipenv install

format:
	python3 -m pipenv install --dev
	python3 -m pipenv run python3 -m autoflake .
	python3 -m pipenv run python3 -m isort .
	python3 -m pipenv run python3 -m black .
