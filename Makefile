NPM=$(shell which npm)
GRUNT=$(shell pwd)/node_modules/grunt-cli/bin/grunt

install:
	$(NPM) install

grunt:
	$(GRUNT)
