SHELL=/bin/bash
GULP=./node_modules/gulp/bin/gulp.js --gulpfile ./gulpfile.babel.js --cwd $(CURDIR)
DOCKER=/usr/local/bin/docker

# Configurable variables 
DIST=./dist
DOCKER-FILE=Dockerfile
DOCKER-REPO=jjperezaguinaga/webpage
DOCKER-REGISTRY=tutum.co

.DEFAULT_GOAL := build-app

build-app:
	$(GULP) build

build-image:
	cp $(DOCKER-FILE) $(DIST)
	$(DOCKER) build -t=$(DOCKER-REPO) $(DIST)

build: build-app build-image

deploy-docker:
	# Assumes docker login 
	$(DOCKER)	tag -f $(DOCKER-REPO) $(DOCKER-REGISTRY)/$(DOCKER-REPO)
	$(DOCKER) push $(DOCKER-REGISTRY)/$(DOCKER-REPO)

deploy: deploy-docker

production: build deploy
