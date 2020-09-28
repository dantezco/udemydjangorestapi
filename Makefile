default: help

# Install all dependencies to local environment
install:
	pipenv install --dev

# Create a new docker container using docker-compose
container:
	docker-compose build

# This is just to remember the command, might become a template later
create-project:
	docker-compose run app sh -c "django-admin.py startproject app ."

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