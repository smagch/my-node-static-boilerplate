HTML = $(shell find ./public -type f -name 'index.html')

STYLUS = stylesheets/home.styl
CSS = $(subst stylesheets/,public/stylesheets/, $(STYLUS:.styl=.css))
STYLUS_LIB = ./node_modules/nib/lib/nib.js
STYLUS_BIN = ./node_modules/.bin/stylus

build: $(CSS)
	DEBUG=dev node support/build.js

public/%.css: %.styl
	@$(STYLUS_BIN) < $< --use $(STYLUS_LIB) --compress > $@

pages:
	@find ./views -type f -name 'index.jade'

clean: $(HTML) $(CSS)
	@rm $(HTML) $(CSS)

.PHONY: clean
