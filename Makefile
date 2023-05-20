SHELL := /bin/bash

clean:
	git clean -xfd -e .idea

dist: clean
	pipenv run python ./setup.py sdist

release: dist
	pipenv run twine upload --sign dist/*

test-release: dist
	pipenv run twine upload --sign --repository-url https://test.pypi.org/legacy/ dist/*
