JADE_BIN = ./node_modules/jade/bin/jade
JADE = $(shell find ./views -type f -name 'index.jade')
HTML = $(patsubst ./views/%,./public/%, $(JADE:.jade=.html))
# HTML_LIBS = $(shell find ./views -type f -name 'base.jade')

STYLUS = $(shell find ./stylesheets/*.styl)
CSS = $(subst stylesheets/,public/stylesheets/, $(STYLUS:.styl=.css))
STYLUS_LIB = ./node_modules/nib/lib/nib.js
STYLUS_BIN = ./node_modules/.bin/stylus

all: ensureDir $(HTML) $(CSS)
	@echo build complete

build:
	@node dev.build.js

ensureDir:
	@mkdir -p $(dir $(CSS) $(HTML))

public/%.html: views/%.jade
	@$(JADE_BIN) < $< --path $< --obj ./locals/index --use base=./locals/i18n/base > $@

public/%.css: %.styl
	@$(STYLUS_BIN) < $< --use $(STYLUS_LIB) --compress > $@

clean:
	@rm -f $(HTML) $(CSS)

.PHONY: clean
