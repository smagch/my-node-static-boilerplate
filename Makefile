JADE_BIN = ./node_modules/.bin/jade
JADE = $(shell find ./views -type f -name 'index.jade')
HTML = $(JADE:.jade=.html)
HTML_DEST = $(patsubst ./views/%,./public/%, $(HTML))

STYLUS = $(shell find ./stylesheets/*.styl)
CSS = $(STYLUS:.styl=.css)
CSS_DEST = $(subst stylesheets/,public/stylesheets/, $(CSS))
STYLUS_LIB = ./node_modules/nib/lib/nib.js
STYLUS_BIN = ./node_modules/.bin/stylus

all: ensureDir $(HTML) $(CSS)

ensureDir:
	@mkdir -p $(dir $(CSS_DEST) $(HTML_DEST))

%.html: %.jade
	$(JADE_BIN) $< 
	@cp $@ $(subst views/,public/, $@)

%.css: %.styl
	$(STYLUS_BIN) $< --use $(STYLUS_LIB) --compress
	@cp $@ $(subst stylesheets/,public/stylesheets/, $@)

clean:
	@rm -f $(HTML) $(HTML_DEST) $(CSS) $(CSS_DEST)

.PHONY: clean
