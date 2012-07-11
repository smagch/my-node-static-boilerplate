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

#### jshint
JSHINT_TARGETS = \
  $(filter-out %-built.js, $(wildcard \
     $(JS_SRC)/modernizr-init.js \
  ))

lint: $(JSHINT_TARGETS)
	@jshint $^

JS_LIB = ./public/javascripts/libs

h5bt:
	@echo curl latest html5-boilerplate css file...
	@curl https://raw.github.com/h5bp/html5-boilerplate/master/css/main.css > ./stylesheets/h5bt.styl

	mkdir -p $(JS_LIB)
	@echo curl latest json2.js...	
	@curl https://raw.github.com/douglascrockford/JSON-js/master/json2.js > $(JS_LIB)/json2.js

	@echo "Let's download Modernizr.custom http://modernizr.com/download/#-printshiv-mq-teststyles-load"

clean: $(HTML) $(CSS)
	@rm $(HTML) $(CSS)

.PHONY: clean
