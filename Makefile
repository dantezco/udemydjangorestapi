default: help

# Install all dependencies to local environment
install:
	pipenv install --dev

# Create a new docker container using docker-compose
container:
	docker-compose build

# Builds, (re)creates starts and attaches to containers for a service, for all
start-app:
	docker-compose up

# Performs unit tests
test:
	docker-compose run app sh -c "python manage.py test && flake8"

# This is just to remember the command, might become a template later
create-project:
	docker-compose run app sh -c "django-admin.py startproject app ."

# Creates migrations for core app
migrations-core:
	docker-compose run app sh -c "python manage.py makemigrations core"

# Display this help
help:
	@echo
	@echo '  Usage:'
	@echo ''
	@echo '              make <target> [flags...]'
	@echo ''
	@echo '  Targets:'
	@echo ''
	@awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?:/{ print "   ", $$1, comment }' ./Makefile | column -t -s ':' | sort
	@echo ''
	@echo '  Flags:'
	@echo ''
	@awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?\?=/{ print "   ", $$1, $$2, comment }' ./Makefile | column -t -s '?=' | sort
	@echo ''