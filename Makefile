## Standard makefile for Python package

BASE_PACKAGE = mypackagename

.PHONY: all package install install_dev test docs publish_docs

all: help

help:
	@echo "AVAILABLE TARGETS"
	@echo "-----------------"
	@echo
	@echo "release - build source distribution and upload to pypi"
	@echo "clearn_release - clean release files"
	@echo
	@echo "install - install project in production mode"
	@echo "install_dev - install project in development mode"
	@echo
	@echo "check (or 'test') - run tests"
	@echo
	@echo "docs - build documentation (HTML)"
	@echo "publish_docs - publish documentation to GitHub pages"

release:
	python setup.py sdist
	@# gpg --detach-sign -a dist/*.tar.gz
	twine upload dist/*

clean_release:
	rm -f dist/*

install:
	python setup.py install

install_dev:
	python setup.py develop

check:
	py.test -vvv --pep8 --cov=$(BASE_PACKAGE) --cov-report=term-missing ./tests

test: check

docs:
	$(MAKE) -C docs html

publish_docs: docs
	ghp-import -n -p ./docs/build/html
	@echo
	@echo "HTML output published on github-pages"
