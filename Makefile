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

# Stops all related containers running
stop-app:
	docker-compose down

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
	@printf '  \033[34mUsage: \033[37m  make <target> [flags...]'
	@echo ''
	@printf '\033[34m';
	@echo '  Targets:'
	@awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?:/{ print "   \033[32m", $$1, "\033[37m", comment }' ./Makefile | column -t -s ':'
	@echo ''
	@printf '\033[34m';
	@echo '  Flags:'
	@awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?\?=/{ print "   \033[32m", $$1, "\033[33m", $$2, "\033[37m", comment }' ./Makefile | column -t -s '?='
